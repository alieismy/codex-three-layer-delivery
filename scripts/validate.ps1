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
        $frontmatter = [regex]::Match($content, "(?s)\A---\n(?<body>.*?)\n---\n")
        if (-not $frontmatter.Success) {
            Add-Failure "Skill must start with valid LF-delimited frontmatter: $($skill.FullName)"
            continue
        }

        $frontmatterBody = $frontmatter.Groups["body"].Value
        $nameMatch = [regex]::Match($frontmatterBody, "(?m)^name:\s*(?<name>[a-z0-9]+(?:-[a-z0-9]+)*)\s*$")
        $descriptionMatch = [regex]::Match(
            $frontmatterBody,
            "(?ms)^description:\s*>-\s*\n(?<description>(?: {2}.+(?:\n|$))+?)\z"
        )
        if (-not ($nameMatch.Success -and $descriptionMatch.Success)) {
            Add-Failure "Skill frontmatter must contain only a valid name and block description: $($skill.FullName)"
            continue
        }

        $name = $nameMatch.Groups["name"].Value
        if ($name -ne $skill.Directory.Name) {
            Add-Failure "Skill name must match its parent directory: $($skill.FullName)"
        }

        $topLevelKeys = [regex]::Matches($frontmatterBody, "(?m)^(?<key>[A-Za-z0-9_-]+):") |
            ForEach-Object { $_.Groups["key"].Value }
        foreach ($key in $topLevelKeys) {
            if ($key -notin @("name", "description")) {
                Add-Failure "Unexpected skill frontmatter field '$key': $($skill.FullName)"
            }
        }

        $description = (($descriptionMatch.Groups["description"].Value -split "\n") |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ }) -join " "
        if ($description.Length -lt 1 -or $description.Length -gt 1024) {
            Add-Failure "Skill description must contain 1-1024 characters: $($skill.FullName)"
        }

        $isChinese = $skill.FullName -match "[\\/]zh-CN[\\/]"
        if ($isChinese -and $description -notmatch "[\u4e00-\u9fff]") {
            Add-Failure "Chinese skill description must contain Simplified Chinese trigger text: $($skill.FullName)"
        }
        if (-not $isChinese -and $description -notmatch '\bUse (when|for)\b') {
            Add-Failure "English skill description must state when or what target to use it for: $($skill.FullName)"
        }

        if (($content -split "\n").Count -gt 500) {
            Add-Failure "SKILL.md exceeds the 500-line progressive-disclosure limit: $($skill.FullName)"
        }
        if ($content -match '\$rd-') {
            Add-Failure "Shared skill bodies must use neutral rd-* identifiers, not platform invocation syntax: $($skill.FullName)"
        }
        if ($content -match "(?m)^## (MCP Tool Usage|MCP 工具使用)$" -or $content.Contains("Codex built-in")) {
            Add-Failure "Platform-specific or hard-coded tool routing found in shared skill: $($skill.FullName)"
        }
    }
}

$skillRoots = @(
    (Join-Path $root "skills"),
    (Join-Path $root "claude/project/.claude/skills"),
    (Join-Path $root "cursor/project/.cursor/skills"),
    (Join-Path $root "cursor/zh-CN/.cursor/skills"),
    (Join-Path $root "zh-CN/skills"),
    (Join-Path $root "zh-CN/claude/project/.claude/skills")
)
foreach ($skillRoot in $skillRoots) {
    Test-SkillFrontmatter -SkillRoot $skillRoot
}

function Test-SkillEvals {
    param([string]$SkillRoot)

    foreach ($skillDirectory in Get-ChildItem -LiteralPath $SkillRoot -Directory -Force) {
        $evalsPath = Join-Path $skillDirectory.FullName "evals/evals.json"
        $triggerPath = Join-Path $skillDirectory.FullName "evals/trigger-evals.json"
        foreach ($requiredPath in @($evalsPath, $triggerPath)) {
            if (-not (Test-Path -LiteralPath $requiredPath)) {
                Add-Failure "Missing required skill evaluation file: $requiredPath"
            }
        }
        if (-not ((Test-Path -LiteralPath $evalsPath) -and (Test-Path -LiteralPath $triggerPath))) {
            continue
        }

        try {
            $evals = Get-Content -LiteralPath $evalsPath -Raw | ConvertFrom-Json
            $triggers = @(Get-Content -LiteralPath $triggerPath -Raw | ConvertFrom-Json)
        }
        catch {
            Add-Failure "Invalid skill evaluation JSON in $($skillDirectory.FullName): $($_.Exception.Message)"
            continue
        }

        if ($evals.skill_name -ne $skillDirectory.Name -or @($evals.evals).Count -lt 3) {
            Add-Failure "Skill output evals must match the skill name and contain at least three cases: $evalsPath"
        }
        foreach ($eval in @($evals.evals)) {
            if (-not $eval.prompt -or -not $eval.expected_output -or @($eval.assertions).Count -lt 1) {
                Add-Failure "Each output eval needs a prompt, expected output, and assertions: $evalsPath"
            }
        }
        $positiveCount = @($triggers | Where-Object { $_.should_trigger -eq $true }).Count
        $negativeCount = @($triggers | Where-Object { $_.should_trigger -eq $false }).Count
        if ($triggers.Count -lt 8 -or $positiveCount -lt 3 -or $negativeCount -lt 3) {
            Add-Failure "Trigger evals need at least eight cases, including three positive and three near-miss negative cases: $triggerPath"
        }
    }
}

foreach ($skillRoot in $skillRoots) {
    Test-SkillEvals -SkillRoot $skillRoot
}

function Test-SkillOpenAiMetadata {
    param([string]$SkillRoot)

    foreach ($skillDirectory in Get-ChildItem -LiteralPath $SkillRoot -Directory -Force) {
        $metadataPath = Join-Path $skillDirectory.FullName "agents/openai.yaml"
        if (-not (Test-Path -LiteralPath $metadataPath)) {
            Add-Failure "Missing ChatGPT/Codex skill metadata: $metadataPath"
            continue
        }

        $metadata = Get-Content -LiteralPath $metadataPath -Raw
        foreach ($requiredKey in @("interface:", "display_name:", "short_description:", "default_prompt:")) {
            if (-not $metadata.Contains($requiredKey)) {
                Add-Failure "Missing '$requiredKey' in skill metadata: $metadataPath"
            }
        }
        $shortDescriptionMatch = [regex]::Match($metadata, '(?m)^\s{2}short_description:\s*"(?<value>[^"]+)"\s*$')
        if (-not $shortDescriptionMatch.Success -or $shortDescriptionMatch.Groups["value"].Value.Length -lt 25 -or $shortDescriptionMatch.Groups["value"].Value.Length -gt 64) {
            Add-Failure "Skill short_description must be a quoted 25-64 character string: $metadataPath"
        }
        $defaultPromptMatch = [regex]::Match($metadata, '(?m)^\s{2}default_prompt:\s*"(?<value>[^"]+)"\s*$')
        if (-not $defaultPromptMatch.Success -or -not $defaultPromptMatch.Groups["value"].Value.Contains("`$$($skillDirectory.Name)")) {
            Add-Failure "Skill default_prompt must be quoted and explicitly mention `$$($skillDirectory.Name): $metadataPath"
        }
        if ($metadata -match "(?m)^dependencies:") {
            Add-Failure "Skill metadata must not add tool dependencies without a documented need: $metadataPath"
        }
        $hasInvocationPolicy = $metadata -match "(?m)^policy:"
        if ($skillDirectory.Name -eq "rd-delivery") {
            if (-not ($metadata -match "(?ms)^policy:\n\s{2}allow_implicit_invocation:\s*false\s*$")) {
                Add-Failure "rd-delivery must disable implicit invocation because it is an explicit orchestrator: $metadataPath"
            }
        }
        elseif ($hasInvocationPolicy) {
            Add-Failure "Specialist Skills must retain the default invocation policy: $metadataPath"
        }
    }
}

foreach ($skillRoot in $skillRoots) {
    Test-SkillOpenAiMetadata -SkillRoot $skillRoot
}

$expectedSkillNames = @(
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

function Assert-ExpectedSkillSet {
    param([string]$SkillRoot)

    if (-not (Test-Path -LiteralPath $SkillRoot)) {
        Add-Failure "Missing skill root: $SkillRoot"
        return
    }

    $actualNames = Get-ChildItem -LiteralPath $SkillRoot -Directory -Force | Select-Object -ExpandProperty Name
    foreach ($expectedName in $expectedSkillNames) {
        if ($actualNames -notcontains $expectedName) {
            Add-Failure "Missing expected document skill '$expectedName' in $SkillRoot"
        }
    }
    foreach ($actualName in $actualNames) {
        if ($expectedSkillNames -notcontains $actualName) {
            Add-Failure "Unexpected non-document skill '$actualName' in $SkillRoot"
        }
    }
}

foreach ($skillRoot in $skillRoots) {
    Assert-ExpectedSkillSet -SkillRoot $skillRoot
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

function Assert-MirroredSkillTree {
    param(
        [string]$SourceRoot,
        [string]$TargetRoot
    )

    $sourceFiles = Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Force
    $targetFiles = Get-ChildItem -LiteralPath $TargetRoot -Recurse -File -Force
    $sourceMap = @{}
    $targetMap = @{}
    foreach ($file in $sourceFiles) {
        $relative = $file.FullName.Substring($SourceRoot.Length).TrimStart("\", "/")
        $sourceMap[$relative] = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
    }
    foreach ($file in $targetFiles) {
        $relative = $file.FullName.Substring($TargetRoot.Length).TrimStart("\", "/")
        $targetMap[$relative] = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
    }
    foreach ($relative in $sourceMap.Keys) {
        if (-not $targetMap.ContainsKey($relative)) {
            Add-Failure "Missing mirrored skill file '$relative' in $TargetRoot"
        }
        elseif ($sourceMap[$relative] -ne $targetMap[$relative]) {
            Add-Failure "Mirrored skill file differs from canonical source: $relative in $TargetRoot"
        }
    }
    foreach ($relative in $targetMap.Keys) {
        if (-not $sourceMap.ContainsKey($relative)) {
            Add-Failure "Unexpected mirrored skill file '$relative' in $TargetRoot"
        }
    }
}

Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "claude/project/.claude/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "cursor/project/.cursor/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "zh-CN/skills") -TargetRoot (Join-Path $root "cursor/zh-CN/.cursor/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "zh-CN/skills")
Assert-MirroredSkillSet -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "zh-CN/claude/project/.claude/skills")

Assert-MirroredSkillTree -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "claude/project/.claude/skills")
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "cursor/project/.cursor/skills")
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "zh-CN/skills") -TargetRoot (Join-Path $root "zh-CN/claude/project/.claude/skills")
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "zh-CN/skills") -TargetRoot (Join-Path $root "cursor/zh-CN/.cursor/skills")

$cursorPlatformFiles = @(
    (Join-Path $root "cursor/project/PROMPTS.md"),
    (Join-Path $root "cursor/zh-CN/PROMPTS.md")
) + @(Get-ChildItem -LiteralPath (Join-Path $root "cursor/project/.cursor/rules") -File -Force) +
    @(Get-ChildItem -LiteralPath (Join-Path $root "cursor/zh-CN/.cursor/rules") -File -Force)
foreach ($cursorFile in $cursorPlatformFiles) {
    $cursorPath = if ($cursorFile -is [System.IO.FileInfo]) { $cursorFile.FullName } else { $cursorFile }
    if ((Get-Content -LiteralPath $cursorPath -Raw).Contains('$rd-')) {
        Add-Failure "Cursor platform files must use /rd-* invocation syntax: $cursorPath"
    }
}

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

$cursorActiveMcpConfigs = @(
    (Join-Path $root "cursor/project/.cursor/mcp.json"),
    (Join-Path $root "cursor/zh-CN/.cursor/mcp.json")
)
foreach ($cursorActiveMcpConfig in $cursorActiveMcpConfigs) {
    if (Test-Path -LiteralPath $cursorActiveMcpConfig) {
        Add-Failure "Cursor adapter must ship MCP as mcp.example.json, not active mcp.json: $cursorActiveMcpConfig"
    }
}

$cursorMcpExamples = @(
    (Join-Path $root "cursor/project/.cursor/mcp.example.json"),
    (Join-Path $root "cursor/zh-CN/.cursor/mcp.example.json")
)
$blockedCursorMcpStrings = @(
    '@latest',
    '"disabled"',
    '"alwaysAllow"',
    'acemcp.heroman.wtf'
)
foreach ($cursorMcpExample in $cursorMcpExamples) {
    if (-not (Test-Path -LiteralPath $cursorMcpExample)) {
        Add-Failure "Missing Cursor MCP example: $cursorMcpExample"
        continue
    }

    $cursorMcpText = Get-Content -LiteralPath $cursorMcpExample -Raw
    foreach ($blocked in $blockedCursorMcpStrings) {
        if ($cursorMcpText.Contains($blocked)) {
            Add-Failure "Unsafe or unsupported Cursor MCP template string found in $cursorMcpExample`: $blocked"
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
