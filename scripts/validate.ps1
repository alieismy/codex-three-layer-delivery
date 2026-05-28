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

$skillFiles = Get-ChildItem -LiteralPath (Join-Path $root "skills") -Recurse -File -Filter "SKILL.md" -Force
foreach ($skill in $skillFiles) {
    $content = Get-Content -LiteralPath $skill.FullName -Raw
    $hasName = $content -match "(?m)^name:\s*rd-[^\r\n]+"
    $hasDescription = $content -match "(?m)^description:\s*(Use when|>-)"
    $descriptionMentionsTrigger = $content -match "Use when"
    if (-not ($hasName -and $hasDescription -and $descriptionMentionsTrigger)) {
        Add-Failure "Skill frontmatter must include name and trigger-oriented description: $($skill.FullName)"
    }
}

$publicConfig = Join-Path $root "codex/examples/config.example.toml"
if (Test-Path -LiteralPath $publicConfig) {
    $configText = Get-Content -LiteralPath $publicConfig -Raw
    $blockedConfigStrings = @(
        'gpt-5.5',
        'danger-full-access',
        'sandbox = "elevated"',
        'acemcp.heroman.wtf',
        'service_tier = "fast"',
        'windows_wsl_setup_acknowledged = true',
        'theme = "dark-neon"'
    )
    foreach ($blocked in $blockedConfigStrings) {
        if ($configText.Contains($blocked)) {
            Add-Failure "Unsafe or private default found in public config: $blocked"
        }
    }
} else {
    Add-Failure "Missing public config example: $publicConfig"
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
