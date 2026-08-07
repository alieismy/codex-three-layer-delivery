[CmdletBinding()]
param(
    [ValidateSet("en", "zh-CN")]
    [string]$Language = "en",

    [string]$DestinationRoot = (Join-Path ([Environment]::GetFolderPath("UserProfile")) ".agents/skills"),

    [string]$BackupRoot = (Join-Path ([Environment]::GetFolderPath("UserProfile")) ".agents/backups"),

    [switch]$CheckOnly
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$sourceRoot = if ($Language -eq "zh-CN") {
    Join-Path $repoRoot "zh-CN/skills"
}
else {
    Join-Path $repoRoot "skills"
}

$skillNames = @(
    "rd-requirement",
    "rd-feasibility",
    "rd-research",
    "rd-solution",
    "rd-design",
    "rd-specification",
    "rd-writing",
    "rd-review",
    "rd-delivery"
)

function Get-NormalizedFullPath {
    param([Parameter(Mandatory)][string]$Path)

    return [System.IO.Path]::GetFullPath($Path).TrimEnd(
        [System.IO.Path]::DirectorySeparatorChar,
        [System.IO.Path]::AltDirectorySeparatorChar
    )
}

function Get-SafeSkillPath {
    param(
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Name
    )

    if ($skillNames -notcontains $Name) {
        throw "Refusing unmanaged Skill name: $Name"
    }

    $normalizedRoot = Get-NormalizedFullPath -Path $Root
    $candidate = Get-NormalizedFullPath -Path (Join-Path $normalizedRoot $Name)
    $expected = [System.IO.Path]::Combine($normalizedRoot, $Name)
    if (-not [string]::Equals($candidate, $expected, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing unexpected Skill path: $candidate"
    }

    return $candidate
}

function Get-TreeManifest {
    param([Parameter(Mandatory)][string]$Root)

    if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
        throw "Missing Skill directory: $Root"
    }

    $manifest = @{}
    foreach ($file in Get-ChildItem -LiteralPath $Root -Recurse -File -Force) {
        $relative = $file.FullName.Substring($Root.Length).TrimStart(
            [System.IO.Path]::DirectorySeparatorChar,
            [System.IO.Path]::AltDirectorySeparatorChar
        ).Replace("\", "/")
        $manifest[$relative] = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
    }
    return $manifest
}

function Compare-SkillTree {
    param(
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Target
    )

    if (-not (Test-Path -LiteralPath $Target -PathType Container)) {
        return @("missing target directory")
    }

    $sourceManifest = Get-TreeManifest -Root $Source
    $targetManifest = Get-TreeManifest -Root $Target
    $differences = [System.Collections.Generic.List[string]]::new()

    foreach ($relative in $sourceManifest.Keys) {
        if (-not $targetManifest.ContainsKey($relative)) {
            $differences.Add("missing: $relative")
        }
        elseif ($sourceManifest[$relative] -ne $targetManifest[$relative]) {
            $differences.Add("changed: $relative")
        }
    }
    foreach ($relative in $targetManifest.Keys) {
        if (-not $sourceManifest.ContainsKey($relative)) {
            $differences.Add("unexpected: $relative")
        }
    }

    return @($differences)
}

foreach ($name in $skillNames) {
    $source = Get-SafeSkillPath -Root $sourceRoot -Name $name
    if (-not (Test-Path -LiteralPath $source -PathType Container)) {
        throw "Missing source Skill: $source"
    }
}

$destination = Get-NormalizedFullPath -Path $DestinationRoot

if ($CheckOnly) {
    $failures = [System.Collections.Generic.List[string]]::new()
    foreach ($name in $skillNames) {
        $source = Get-SafeSkillPath -Root $sourceRoot -Name $name
        $target = Get-SafeSkillPath -Root $destination -Name $name
        foreach ($difference in Compare-SkillTree -Source $source -Target $target) {
            $failures.Add("$name - $difference")
        }
    }

    if ($failures.Count -gt 0) {
        Write-Host "RD Skill installation differs from the $Language source:" -ForegroundColor Red
        foreach ($failure in $failures) {
            Write-Host " - $failure" -ForegroundColor Red
        }
        exit 1
    }

    Write-Host "RD Skill installation matches all nine $Language source trees." -ForegroundColor Green
    exit 0
}

[System.IO.Directory]::CreateDirectory($destination) | Out-Null
$normalizedBackupRoot = Get-NormalizedFullPath -Path $BackupRoot
[System.IO.Directory]::CreateDirectory($normalizedBackupRoot) | Out-Null
$stamp = Get-Date -Format "yyyyMMdd-HHmmss-fff"
$backupSet = Join-Path $normalizedBackupRoot "rd-skills-$stamp"
[System.IO.Directory]::CreateDirectory($backupSet) | Out-Null

$backedUp = [System.Collections.Generic.List[string]]::new()
try {
    foreach ($name in $skillNames) {
        $target = Get-SafeSkillPath -Root $destination -Name $name
        if (Test-Path -LiteralPath $target) {
            $backupTarget = Get-SafeSkillPath -Root $backupSet -Name $name
            Copy-Item -LiteralPath $target -Destination $backupTarget -Recurse
            $backedUp.Add($name)
        }
    }

    foreach ($name in $backedUp) {
        $original = Get-SafeSkillPath -Root $destination -Name $name
        $backup = Get-SafeSkillPath -Root $backupSet -Name $name
        $backupDifferences = @(Compare-SkillTree -Source $original -Target $backup)
        if ($backupDifferences.Count -gt 0) {
            throw "Backup verification failed for $name`: $($backupDifferences -join '; ')"
        }
    }

    $backupManifest = foreach ($name in $backedUp) {
        $backup = Get-SafeSkillPath -Root $backupSet -Name $name
        $tree = Get-TreeManifest -Root $backup
        foreach ($relative in $tree.Keys | Sort-Object) {
            [pscustomobject]@{
                skill = $name
                path = $relative
                sha256 = $tree[$relative]
            }
        }
    }
    $manifestPath = Join-Path $backupSet "manifest.sha256.json"
    $manifestJson = if ($null -eq $backupManifest) {
        "[]"
    }
    else {
        $backupManifest | ConvertTo-Json -Depth 4
    }
    [System.IO.File]::WriteAllText(
        $manifestPath,
        $manifestJson,
        [System.Text.UTF8Encoding]::new($false)
    )
}
catch {
    $backupError = $_
    $failedBackupSet = Join-Path $normalizedBackupRoot "failed-rd-skills-$stamp-before-replacement"
    if (Test-Path -LiteralPath $backupSet) {
        Move-Item -LiteralPath $backupSet -Destination $failedBackupSet
    }
    throw "Backup creation failed; the installation was not changed. Incomplete backup: $failedBackupSet. Error: $($backupError.Exception.Message)"
}

$destinationParent = Get-NormalizedFullPath -Path ([System.IO.Path]::GetDirectoryName($destination))
$stageRoot = Get-NormalizedFullPath -Path (Join-Path $destinationParent ".rd-skills-stage-$([guid]::NewGuid().ToString('N'))")
$expectedStagePrefix = "$destinationParent$([System.IO.Path]::DirectorySeparatorChar).rd-skills-stage-"
if (-not $stageRoot.StartsWith($expectedStagePrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing unexpected staging path: $stageRoot"
}
[System.IO.Directory]::CreateDirectory($stageRoot) | Out-Null

try {
    foreach ($name in $skillNames) {
        $source = Get-SafeSkillPath -Root $sourceRoot -Name $name
        $stage = Get-SafeSkillPath -Root $stageRoot -Name $name
        Copy-Item -LiteralPath $source -Destination $stage -Recurse
        $stageDifferences = @(Compare-SkillTree -Source $source -Target $stage)
        if ($stageDifferences.Count -gt 0) {
            throw "Staging verification failed for $name`: $($stageDifferences -join '; ')"
        }
    }

    foreach ($name in $skillNames) {
        $target = Get-SafeSkillPath -Root $destination -Name $name
        $stage = Get-SafeSkillPath -Root $stageRoot -Name $name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        Move-Item -LiteralPath $stage -Destination $target
    }
}
catch {
    $installError = $_
    foreach ($name in $skillNames) {
        $target = Get-SafeSkillPath -Root $destination -Name $name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        if ($backedUp -contains $name) {
            $backup = Get-SafeSkillPath -Root $backupSet -Name $name
            Copy-Item -LiteralPath $backup -Destination $target -Recurse
        }
    }
    throw "RD Skill installation failed and the previous installation was restored: $($installError.Exception.Message)"
}
finally {
    if (Test-Path -LiteralPath $stageRoot) {
        Remove-Item -LiteralPath $stageRoot -Recurse -Force
    }
}

$installFailures = [System.Collections.Generic.List[string]]::new()
foreach ($name in $skillNames) {
    $source = Get-SafeSkillPath -Root $sourceRoot -Name $name
    $target = Get-SafeSkillPath -Root $destination -Name $name
    foreach ($difference in Compare-SkillTree -Source $source -Target $target) {
        $installFailures.Add("$name - $difference")
    }
}
if ($installFailures.Count -gt 0) {
    foreach ($name in $skillNames) {
        $target = Get-SafeSkillPath -Root $destination -Name $name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        if ($backedUp -contains $name) {
            $backup = Get-SafeSkillPath -Root $backupSet -Name $name
            Copy-Item -LiteralPath $backup -Destination $target -Recurse
        }
    }
    throw "Installed RD Skills failed verification and the previous installation was restored: $($installFailures -join '; ')"
}

Write-Host "Installed and verified all nine $Language RD Skills in $destination" -ForegroundColor Green
Write-Host "Verified backup: $backupSet" -ForegroundColor Green
Write-Host "Restart Codex if the updated Skill metadata is not visible in the current session."
