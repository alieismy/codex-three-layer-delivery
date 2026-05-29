$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
}

function Get-TextFiles {
    $patterns = @("*.md", "*.mdc", "*.mdx", "*.markdown", "*.toml", "*.json", "*.jsonc", "*.yaml", "*.yml", "*.ps1")
    foreach ($pattern in $patterns) {
        Get-ChildItem -LiteralPath $root -Recurse -File -Filter $pattern -Force
    }
    Get-ChildItem -LiteralPath $root -Force -File |
        Where-Object { $_.Name -in @(".gitattributes", ".gitignore", ".env.example") }
}

$textFiles = Get-TextFiles | Sort-Object -Property FullName -Unique

foreach ($file in $textFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    if ($bytes.Length -ge 2) {
        for ($i = 0; $i -lt ($bytes.Length - 1); $i++) {
            if ($bytes[$i] -eq 13 -and $bytes[$i + 1] -eq 10) {
                Add-Failure "CRLF line ending found: $($file.FullName)"
                break
            }
        }
    }
}

function Test-SkillFrontmatter {
    param([string]$SkillRoot)

    if (-not (Test-Path -LiteralPath $SkillRoot)) {
        return
    }

    $skillFiles = Get-ChildItem -LiteralPath $SkillRoot -Recurse -File -Filter "SKILL.md" -Force
    foreach ($skill in $skillFiles) {
        $content = Get-Content -LiteralPath $skill.FullName -Raw
        $hasName = $content -match "(?m)^name:\s*rd-[^\r\n]+"
        $hasDescription = $content -match "(?m)^description:\s*(Use when|>-)"
        $descriptionMentionsTrigger = $content -match "Use when"
        if (-not ($hasName -and $hasDescription -and $descriptionMentionsTrigger)) {
            Add-Failure "Skill frontmatter must include name and trigger-oriented description: $($skill.FullName)"
        }
    }
}

$skillRoots = @(
    (Join-Path $root "skills"),
    (Join-Path $root "claude/project/.claude/skills"),
    (Join-Path $root "zh-CN/skills"),
    (Join-Path $root "zh-CN/claude/project/.claude/skills")
)
foreach ($skillRoot in $skillRoots) {
    Test-SkillFrontmatter -SkillRoot $skillRoot
}

function Assert-MirroredSkillSet {
    param(
        [string]$SourceRoot,
        [string]$TargetRoot
    )

    if (-not (Test-Path -LiteralPath $TargetRoot)) {
        Add-Failure "Missing mirrored skill directory: $TargetRoot"
        return
    }

    $sourceNames = Get-ChildItem -LiteralPath $SourceRoot -Directory -Force | Select-Object -ExpandProperty Name
    $targetNames = Get-ChildItem -LiteralPath $TargetRoot -Directory -Force | Select-Object -ExpandProperty Name
    foreach ($sourceName in $sourceNames) {
        if ($targetNames -notcontains $sourceName) {
            Add-Failure "Missing mirrored skill '$sourceName' in $TargetRoot"
        }
    }
    foreach ($targetName in $targetNames) {
        if ($sourceNames -notcontains $targetName) {
            Add-Failure "Unexpected skill '$targetName' in $TargetRoot"
        }
    }
}

Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "claude/project/.claude/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "zh-CN/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "zh-CN/claude/project/.claude/skills")

$publicConfigs = @(
    (Join-Path $root "codex/examples/config.example.toml"),
    (Join-Path $root "zh-CN/codex/examples/config.example.toml")
)
$blockedConfigStrings = @(
    'gpt-5.5',
    'danger-full-access',
    'sandbox = "elevated"',
    'acemcp.heroman.wtf',
    'service_tier = "fast"',
    'windows_wsl_setup_acknowledged = true',
    'theme = "dark-neon"'
)
foreach ($publicConfig in $publicConfigs) {
    if (-not (Test-Path -LiteralPath $publicConfig)) {
        Add-Failure "Missing public config example: $publicConfig"
        continue
    }

    $configText = Get-Content -LiteralPath $publicConfig -Raw
    foreach ($blocked in $blockedConfigStrings) {
        if ($configText.Contains($blocked)) {
            Add-Failure "Unsafe or private default found in public config $publicConfig`: $blocked"
        }
    }
}

$scanFiles = $textFiles | Where-Object {
    $_.FullName -ne (Join-Path $root "scripts/validate.ps1")
}

$allText = foreach ($file in $scanFiles) {
    Get-Content -LiteralPath $file.FullName -Raw
}
$joined = $allText -join "`n"

$blockedRepoStrings = @(
    'Restart Cursor after setting user-level variables.',
    'codex_three_layer_delivery_v4-en',
    'codex-cli 0.132.0'
)
foreach ($blocked in $blockedRepoStrings) {
    if ($joined.Contains($blocked)) {
        Add-Failure "Stale private/internal string found: $blocked"
    }
}

$secretPatterns = @(
    'sk-[A-Za-z0-9_-]{20,}',
    'ghp_[A-Za-z0-9_]{20,}',
    'xox[baprs]-[A-Za-z0-9-]{20,}',
    '-----BEGIN (RSA |EC |OPENSSH |)PRIVATE KEY-----'
)
foreach ($pattern in $secretPatterns) {
    if ($joined -match $pattern) {
        Add-Failure "Potential secret pattern found: $pattern"
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Validation failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host " - $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Validation passed." -ForegroundColor Green
