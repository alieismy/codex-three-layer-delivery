$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
}

function Get-TextFiles {
    $patterns = @("*.md", "*.mdc", "*.mdx", "*.markdown", "*.toml", "*.json", "*.jsonc", "*.yaml", "*.yml", "*.ps1")
    $candidates = @(
        foreach ($pattern in $patterns) {
            Get-ChildItem -LiteralPath $root -Recurse -File -Filter $pattern -Force
        }
        Get-ChildItem -LiteralPath $root -Force -File |
            Where-Object { $_.Name -in @(".gitattributes", ".gitignore", ".env.example") }
    )

    foreach ($candidate in $candidates) {
        $relative = [System.IO.Path]::GetRelativePath([string]$root, $candidate.FullName).Replace("\", "/")
        if ($relative -notlike ".git/*" -and $relative -notlike ".tmp/local/*") {
            $candidate
        }
    }
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
            "(?ms)^description:\s*>-\s*\n(?<description>(?: {2}.+(?:\n|$))+?)(?=^[A-Za-z0-9_-]+:|\z)"
        )
        if (-not ($nameMatch.Success -and $descriptionMatch.Success)) {
            Add-Failure "Skill frontmatter must contain a valid name and block description: $($skill.FullName)"
            continue
        }

        $name = $nameMatch.Groups["name"].Value
        if ($name -ne $skill.Directory.Name) {
            Add-Failure "Skill name must match its parent directory: $($skill.FullName)"
        }

        $isPlatformAdapter = $skill.FullName -match "[\\/]\.(claude|cursor)[\\/]skills[\\/]"
        $hasExplicitInvocationField = $frontmatterBody -match "(?m)^disable-model-invocation:\s*true\s*$"
        $topLevelKeys = [regex]::Matches($frontmatterBody, "(?m)^(?<key>[A-Za-z0-9_-]+):") |
            ForEach-Object { $_.Groups["key"].Value }
        foreach ($key in $topLevelKeys) {
            $isAllowedInvocationKey = (
                $key -eq "disable-model-invocation" -and
                $isPlatformAdapter -and
                $name -eq "rd-delivery"
            )
            if ($key -notin @("name", "description") -and -not $isAllowedInvocationKey) {
                Add-Failure "Unexpected skill frontmatter field '$key': $($skill.FullName)"
            }
        }
        if ($isPlatformAdapter -and $name -eq "rd-delivery" -and -not $hasExplicitInvocationField) {
            Add-Failure "Claude and Cursor rd-delivery adapters must disable model invocation: $($skill.FullName)"
        }
        if (($name -ne "rd-delivery" -or -not $isPlatformAdapter) -and $hasExplicitInvocationField) {
            Add-Failure "Only Claude and Cursor rd-delivery adapters may disable model invocation in SKILL.md: $($skill.FullName)"
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
        $stepMatches = [regex]::Matches($content, "(?m)^### \d+\..*$")
        $completionCriterionMatches = [regex]::Matches(
            $content,
            "(?m)^\*\*(Completion criterion:|完成标准：)\*\*"
        )
        if ($stepMatches.Count -ne $completionCriterionMatches.Count) {
            Add-Failure "Numbered Skill steps and completion criteria must have a one-to-one count: $($skill.FullName)"
        }
        for ($stepIndex = 0; $stepIndex -lt $stepMatches.Count; $stepIndex++) {
            $stepMatch = $stepMatches[$stepIndex]
            $segmentEnd = if ($stepIndex + 1 -lt $stepMatches.Count) {
                $stepMatches[$stepIndex + 1].Index
            }
            else {
                $content.Length
            }
            $stepSegment = $content.Substring($stepMatch.Index, $segmentEnd - $stepMatch.Index)
            $stepCriterionCount = [regex]::Matches(
                $stepSegment,
                "(?m)^\*\*(Completion criterion:|完成标准：)\*\*"
            ).Count
            if ($stepCriterionCount -ne 1) {
                Add-Failure "Each numbered Skill step must contain exactly one completion criterion ('$($stepMatch.Value)'): $($skill.FullName)"
            }
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

function Test-ContainsAllMarkers {
    param(
        [string]$Text,
        [string[]]$Markers
    )

    foreach ($marker in $Markers) {
        if ($Text.IndexOf($marker, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
            return $false
        }
    }
    return $true
}

$rdEvidenceContractBaselines = @(
    @{
        Name = "rd-research"
        SkillPath = "skills/rd-research/SKILL.md"
        EvalPath = "skills/rd-research/evals/evals.json"
        TriggerPath = "skills/rd-research/evals/trigger-evals.json"
        SkillMarkers = @("highest evidence state", "final generated or effective configuration", "runtime state", "business/production acceptance", "no-change")
        EvalMarkers = @("highest established evidence state", "runtime or production", "no-change")
        TriggerMarkers = @("verified and approved", "apply", "research report")
    },
    @{
        Name = "rd-review"
        SkillPath = "skills/rd-review/SKILL.md"
        EvalPath = "skills/rd-review/evals/evals.json"
        TriggerPath = "skills/rd-review/evals/trigger-evals.json"
        SkillMarkers = @("highest evidence state", "final generated or effective configuration", "runtime", "business/production acceptance", "no-change")
        EvalMarkers = @("highest established evidence state", "runtime or production", "no-change")
        TriggerMarkers = @("approved patch", "apply", "review verdict")
    },
    @{
        Name = "rd-research"
        SkillPath = "zh-CN/skills/rd-research/SKILL.md"
        EvalPath = "zh-CN/skills/rd-research/evals/evals.json"
        TriggerPath = "zh-CN/skills/rd-research/evals/trigger-evals.json"
        SkillMarkers = @("最高证据状态", "最终生成或实际生效配置", "运行状态", "业务/生产验收", "无需修改")
        EvalMarkers = @("最高证据状态", "运行或生产", "无需修改")
        TriggerMarkers = @("核实并批准", "直接应用", "研究报告")
    },
    @{
        Name = "rd-review"
        SkillPath = "zh-CN/skills/rd-review/SKILL.md"
        EvalPath = "zh-CN/skills/rd-review/evals/evals.json"
        TriggerPath = "zh-CN/skills/rd-review/evals/trigger-evals.json"
        SkillMarkers = @("最高证据状态", "最终生成或实际生效配置", "运行状态", "业务/生产验收", "无需修改")
        EvalMarkers = @("最高证据状态", "运行或生产", "无需修改")
        TriggerMarkers = @("已批准补丁", "直接应用", "评审结论")
    }
)
foreach ($baseline in $rdEvidenceContractBaselines) {
    $skillPath = Join-Path $root $baseline.SkillPath
    $evalPath = Join-Path $root $baseline.EvalPath
    $triggerPath = Join-Path $root $baseline.TriggerPath

    if (-not (Test-Path -LiteralPath $skillPath)) {
        Add-Failure "Missing RD specialist contract: $skillPath"
    }
    else {
        $skillText = Get-Content -LiteralPath $skillPath -Raw
        foreach ($marker in $baseline.SkillMarkers) {
            if ($skillText.IndexOf($marker, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
                Add-Failure "RD specialist contract is missing '$marker': $skillPath"
            }
        }
    }

    if (Test-Path -LiteralPath $evalPath) {
        try {
            $evalDocument = Get-Content -LiteralPath $evalPath -Raw | ConvertFrom-Json
            $boundaryEvals = @(
                $evalDocument.evals | Where-Object {
                    $evalText = $_ | ConvertTo-Json -Depth 20 -Compress
                    Test-ContainsAllMarkers -Text $evalText -Markers $baseline.EvalMarkers
                }
            )
            if ($boundaryEvals.Count -lt 1) {
                Add-Failure "$($baseline.Name) must include the evidence-boundary/no-change output eval: $evalPath"
            }
        }
        catch {
            Add-Failure "Unable to inspect RD specialist output eval contract in $evalPath`: $($_.Exception.Message)"
        }
    }

    if (Test-Path -LiteralPath $triggerPath) {
        try {
            $triggerDocument = @(Get-Content -LiteralPath $triggerPath -Raw | ConvertFrom-Json)
            $implementationNearMisses = @(
                $triggerDocument | Where-Object {
                    $_.should_trigger -eq $false -and
                    (Test-ContainsAllMarkers -Text $_.query -Markers $baseline.TriggerMarkers)
                }
            )
            if ($implementationNearMisses.Count -lt 1) {
                Add-Failure "$($baseline.Name) trigger evals must keep the approved-fix implementation near-miss negative: $triggerPath"
            }
        }
        catch {
            Add-Failure "Unable to inspect RD specialist trigger contract in $triggerPath`: $($_.Exception.Message)"
        }
    }
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
        [string]$TargetRoot,
        [switch]$AllowPlatformInvocationDifference
    )

    $sourceFiles = Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Force
    $targetFiles = Get-ChildItem -LiteralPath $TargetRoot -Recurse -File -Force
    $sourceMap = @{}
    $targetMap = @{}
    foreach ($file in $sourceFiles) {
        $relative = $file.FullName.Substring($SourceRoot.Length).TrimStart("\", "/")
        $normalizedRelative = $relative.Replace("\", "/")
        $content = Get-Content -LiteralPath $file.FullName -Raw
        if ($AllowPlatformInvocationDifference -and $normalizedRelative -eq "rd-delivery/SKILL.md") {
            $content = $content -replace "(?m)^disable-model-invocation:\s*true\n", ""
        }
        $sourceMap[$relative] = $content
    }
    foreach ($file in $targetFiles) {
        $relative = $file.FullName.Substring($TargetRoot.Length).TrimStart("\", "/")
        $normalizedRelative = $relative.Replace("\", "/")
        $content = Get-Content -LiteralPath $file.FullName -Raw
        if ($AllowPlatformInvocationDifference -and $normalizedRelative -eq "rd-delivery/SKILL.md") {
            $content = $content -replace "(?m)^disable-model-invocation:\s*true\n", ""
        }
        $targetMap[$relative] = $content
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

Assert-MirroredSkillTree -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "claude/project/.claude/skills") -AllowPlatformInvocationDifference
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "skills") -TargetRoot (Join-Path $root "cursor/project/.cursor/skills") -AllowPlatformInvocationDifference
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "zh-CN/skills") -TargetRoot (Join-Path $root "zh-CN/claude/project/.claude/skills") -AllowPlatformInvocationDifference
Assert-MirroredSkillTree -SourceRoot (Join-Path $root "zh-CN/skills") -TargetRoot (Join-Path $root "cursor/zh-CN/.cursor/skills") -AllowPlatformInvocationDifference

$globalAgentBaselines = @(
    @{
        Path = Join-Path $root "codex/global/AGENTS.md"
        Headings = @("## Truthfulness Discipline", "## Response Modes", "## Task Identification and Skill Routing", "## Minimum RD Delivery Baseline", "## Implementation Discipline", "## Context Health", "## Pre-Output Self-Review", "## Output Contract")
        Domains = @("Requirements", "Feasibility", "Research", "Solution", "Design", "Specification", "Writing", "Review", "Delivery orchestration")
        Markers = @(
            "Personal Global Instructions (v7.6)",
            "Say when something is unknown or cannot be confirmed",
            "Keep evidence states separate:",
            "retaining the current state is a valid professional conclusion",
            "**Fast mode:**",
            "**Deep mode:**",
            "**Clarification mode:**",
            "**Guidance mode:**",
            "initial request and the initial interpretation may both be incomplete",
            "Do not add speculative features, extension points, abstractions, pass-through layers, or dependencies",
            "same domain concept and is expected to change for the same reason",
            "Use names that convey domain roles at the scope where ambiguity matters",
            "Validate and normalize untrusted or weakly typed data at trust or representation boundaries",
            "Once a domain value establishes its invariants, rely on them within the same trusted component",
            "Avoid boolean flags that select materially different behavior or create hidden modes",
            "Public API documentation still describes the contract",
            "Preserve uncommitted user or third-party work",
            "Do not remove or change existing behavior, compatibility, or instruction surfaces unless the request or an approved design requires it",
            "other instruction files as scope-sensitive; make only required companion updates and report them",
            "When validation fails, determine whether the current change introduced it",
            "report pre-existing or unrelated failures without silently expanding scope",
            "1. Does the response answer the current request",
            "8. Does the output expose any secret"
        )
        Colon = ":"
    },
    @{
        Path = Join-Path $root "zh-CN/codex/global/AGENTS.md"
        Headings = @("## 真实性纪律", "## 响应模式", "## 任务识别与 Skill 路由", "## RD 交付最小基线", "## 实现纪律", "## 上下文健康", "## 输出前自我审核", "## 输出格式")
        Domains = @("需求", "可研", "研究", "方案", "设计", "标准", "写作", "评审", "交付编排")
        Markers = @(
            "个人全局指令（v7.6）",
            "不知道就明确说不知道；不能确认就明确说不能确认",
            "严格区分证据状态：",
            '“保持现状”是合法的专业结论',
            "**快速模式：**",
            "**深度模式：**",
            "**澄清模式：**",
            "**引导模式：**",
            "初始诉求和首次理解都可能不完整",
            "不添加投机性功能、扩展点、抽象、透传层或依赖",
            "同一领域概念且预计会因同一原因变化",
            "在歧义会影响理解的作用域使用能表达领域角色的名称",
            "在信任边界或表示边界验证并规范化不可信或弱类型数据",
            "领域值一旦建立不变量，同一可信组件内部应依赖这些不变量",
            "避免使用会选择实质不同的行为或创建隐藏模式的 boolean flag",
            "公共 API 文档仍应说明契约",
            "保留用户或第三方的未提交工作",
            "当前请求或已批准设计未要求时，不得移除或改变既有行为、兼容性或指令面",
            "等指令文件时，只执行批准范围和必要的一致性同步，并单独汇报",
            "验证失败时先判断是否由本次改动引入",
            "对既存或无关失败准确报告，不静默扩大范围",
            "1. 是否回答当前请求",
            "8. 输出是否泄露密钥"
        )
        Colon = "："
    }
)
foreach ($baseline in $globalAgentBaselines) {
    if (-not (Test-Path -LiteralPath $baseline.Path)) {
        Add-Failure "Missing global AGENTS.md baseline: $($baseline.Path)"
        continue
    }

    $baselineText = Get-Content -LiteralPath $baseline.Path -Raw
    foreach ($heading in $baseline.Headings) {
        if (-not $baselineText.Contains($heading)) {
            Add-Failure "Global AGENTS.md is missing required routing or fallback heading '$heading': $($baseline.Path)"
        }
    }
    foreach ($domain in $baseline.Domains) {
        $domainMarker = "- **{0}{1}**" -f $domain, $baseline.Colon
        if (-not $baselineText.Contains($domainMarker)) {
            Add-Failure "Global AGENTS.md is missing minimum RD domain '$domain': $($baseline.Path)"
        }
    }
    foreach ($marker in $baseline.Markers) {
        if (-not $baselineText.Contains($marker)) {
            Add-Failure "Global AGENTS.md is missing required always-on behavior '$marker': $($baseline.Path)"
        }
    }
}

$evidenceContractBaselines = @(
    @{
        Paths = @(
            "codex/global/AGENTS.md",
            "codex/project/AGENTS.md",
            "claude/global/CLAUDE.md",
            "claude/project/CLAUDE.md",
            "cursor/project/.cursor/rules/05-research-evidence.mdc"
        )
        Markers = @("documentation claim", "source implementation", "static configuration", "final generated or effective configuration", "runtime state", "production acceptance")
        NoChangeMarkers = @("no-change", "retaining the current state")
    },
    @{
        Paths = @(
            "zh-CN/codex/global/AGENTS.md",
            "zh-CN/codex/project/AGENTS.md",
            "zh-CN/claude/global/CLAUDE.md",
            "zh-CN/claude/project/CLAUDE.md",
            "cursor/zh-CN/.cursor/rules/05-research-evidence.mdc"
        )
        Markers = @("文档声明", "源码实现", "静态配置", "最终生成或实际生效配置", "运行状态", "生产验收")
        NoChangeMarkers = @("无需修改", "保持现状")
    }
)
foreach ($baseline in $evidenceContractBaselines) {
    foreach ($relativePath in $baseline.Paths) {
        $path = Join-Path $root $relativePath
        if (-not (Test-Path -LiteralPath $path)) {
            Add-Failure "Missing evidence-contract surface: $path"
            continue
        }

        $text = Get-Content -LiteralPath $path -Raw
        foreach ($marker in $baseline.Markers) {
            if (-not $text.Contains($marker)) {
                Add-Failure "Evidence-contract surface is missing '$marker': $path"
            }
        }
        $hasNoChangeMarker = @($baseline.NoChangeMarkers | Where-Object { $text.Contains($_) }).Count -gt 0
        if (-not $hasNoChangeMarker) {
            Add-Failure "Evidence-contract surface must allow a supported no-change conclusion: $path"
        }
    }
}

$activeProjectAgents = Join-Path $root "AGENTS.md"
if (-not (Test-Path -LiteralPath $activeProjectAgents)) {
    Add-Failure "Missing repository-root maintainer AGENTS.md: $activeProjectAgents"
}
else {
    $activeText = Get-Content -LiteralPath $activeProjectAgents -Raw
    $rootMaintainerMarkers = @(
        "Repository Maintainer Instructions",
        "not a distributable project template",
        "The English root is the canonical baseline",
        "codex/global/AGENTS.md",
        "codex/project/AGENTS.md",
        ".tmp/local/",
        "pwsh ./scripts/validate.ps1",
        "pwsh ./scripts/test-validator.ps1",
        "first meaningful checkpoint",
        "current goals, progress",
        "task plan or delivery record",
        "docs/release-checklist.md",
        "explicit authority"
    )
    foreach ($marker in $rootMaintainerMarkers) {
        if (-not $activeText.Contains($marker)) {
            Add-Failure "Repository-root maintainer AGENTS.md is missing required contract '$marker': $activeProjectAgents"
        }
    }
}

$contextReuseBaselines = @(
    @{
        Paths = @(
            "codex/project/AGENTS.md",
            "claude/project/CLAUDE.md",
            "cursor/project/.cursor/rules/04-context-session.mdc"
        )
        Markers = @(
            "authoritative source, revision, and applicability",
            "branch and HEAD",
            "context compaction",
            "first meaningful checkpoint",
            "current goals, progress",
            "task plan or delivery record"
        )
    },
    @{
        Paths = @(
            "zh-CN/codex/project/AGENTS.md",
            "zh-CN/claude/project/CLAUDE.md",
            "cursor/zh-CN/.cursor/rules/04-context-session.mdc"
        )
        Markers = @(
            "权威来源、修订标识和适用范围",
            "分支与 HEAD",
            "上下文压缩",
            "第一个有意义的检查点",
            "当前目标、进度",
            "任务计划或交付记录"
        )
    }
)
foreach ($baseline in $contextReuseBaselines) {
    foreach ($relativePath in $baseline.Paths) {
        $path = Join-Path $root $relativePath
        if (-not (Test-Path -LiteralPath $path)) {
            Add-Failure "Missing context-reuse surface: $path"
            continue
        }

        $text = Get-Content -LiteralPath $path -Raw
        foreach ($marker in $baseline.Markers) {
            if (-not $text.Contains($marker)) {
                Add-Failure "Context-reuse surface is missing '$marker': $path"
            }
        }
    }
}

$greenfieldPromptBaselines = @(
    @{
        Paths = @(
            "PROMPTS.md",
            "cursor/project/PROMPTS.md"
        )
        Markers = @(
            "Greenfield Open-Source Landscape and Solution Gate",
            "Do not use it for small fixes or implementation under an already approved architecture.",
            "GitHub is a candidate source, not the sole authority.",
            "Stop at the approval gate",
            "Implementation is outside the RD Skills' delivery boundary",
            ".tmp/local/"
        )
    },
    @{
        Paths = @(
            "zh-CN/PROMPTS.md",
            "cursor/zh-CN/PROMPTS.md"
        )
        Markers = @(
            "绿地开源格局研究与方案门禁",
            "不得用于小修复或已批准架构下的实现",
            "GitHub 是候选来源，不是唯一权威",
            "在批准门禁处停止",
            "实现不属于 RD Skills 的交付边界",
            ".tmp/local/"
        )
    }
)
foreach ($baseline in $greenfieldPromptBaselines) {
    foreach ($relativePath in $baseline.Paths) {
        $path = Join-Path $root $relativePath
        if (-not (Test-Path -LiteralPath $path)) {
            Add-Failure "Missing greenfield research-gate surface: $path"
            continue
        }

        $text = Get-Content -LiteralPath $path -Raw
        foreach ($marker in $baseline.Markers) {
            if (-not $text.Contains($marker)) {
                Add-Failure "Greenfield research-gate surface is missing '$marker': $path"
            }
        }
    }
}

$adversarialClarificationPromptBaselines = @(
    @{
        Paths = @(
            "PROMPTS.md",
            "cursor/project/PROMPTS.md"
        )
        Markers = @(
            "High-Impact Bidirectional Argument and Critical Clarification",
            "This is an optional preamble, not a standalone Skill.",
            "Do not manufacture symmetry",
            "If exactly one unresolved decision that only I can make blocks the final judgment",
            "Do not expose hidden chain of thought."
        )
    },
    @{
        Paths = @(
            "zh-CN/PROMPTS.md",
            "cursor/zh-CN/PROMPTS.md"
        )
        Markers = @(
            "高影响决策的双向论证与关键澄清",
            "这是可选前置段，不是独立 Skill。",
            "不要为了形式制造对称",
            "如果恰有一个仍未解决、只能由我作出且会阻塞最终判断的决策问题",
            "不要输出隐藏思维链。"
        )
    }
)
foreach ($baseline in $adversarialClarificationPromptBaselines) {
    foreach ($relativePath in $baseline.Paths) {
        $path = Join-Path $root $relativePath
        if (-not (Test-Path -LiteralPath $path)) {
            Add-Failure "Missing adversarial clarification-preamble surface: $path"
            continue
        }

        $text = Get-Content -LiteralPath $path -Raw
        foreach ($marker in $baseline.Markers) {
            if (-not $text.Contains($marker)) {
                Add-Failure "Adversarial clarification-preamble surface is missing '$marker': $path"
            }
        }
    }
}

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

function Get-SingleRegexCapture {
    param(
        [string]$Path,
        [string]$Pattern,
        [string]$GroupName,
        [string]$Label
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        Add-Failure "Missing $Label file: $Path"
        return $null
    }

    $versionMatches = [regex]::Matches((Get-Content -LiteralPath $Path -Raw), $Pattern)
    if ($versionMatches.Count -ne 1) {
        Add-Failure "$Label must contain exactly one machine-checkable version value: $Path"
        return $null
    }

    return $versionMatches[0].Groups[$GroupName].Value
}

$semverPattern = '[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?'
$context7TablePattern = "(?m)^\| Context7\s*\|\s*[^|]+\|\s*[^0-9|]*(?<tested>$semverPattern)[^|]*\|\s*[^0-9|]*(?<latest>$semverPattern)[^|]*\|"
$context7PackagePattern = "@upstash/context7-mcp@(?<version>$semverPattern)"
$context7CompatibilityPaths = @(
    (Join-Path $root "docs/compatibility.md"),
    (Join-Path $root "zh-CN/docs/compatibility.md")
)
$context7ConfigPaths = @(
    (Join-Path $root "codex/examples/config.example.toml"),
    (Join-Path $root "zh-CN/codex/examples/config.example.toml"),
    (Join-Path $root "cursor/project/.cursor/mcp.example.json"),
    (Join-Path $root "cursor/zh-CN/.cursor/mcp.example.json")
)
$context7TestedVersions = @(
    foreach ($path in $context7CompatibilityPaths) {
        Get-SingleRegexCapture -Path $path -Pattern $context7TablePattern -GroupName "tested" -Label "Context7 compatibility table"
    }
) | Where-Object { $_ }
$context7LatestVersions = @(
    foreach ($path in $context7CompatibilityPaths) {
        Get-SingleRegexCapture -Path $path -Pattern $context7TablePattern -GroupName "latest" -Label "Context7 compatibility table"
    }
) | Where-Object { $_ }
$context7PinnedVersions = @(
    foreach ($path in $context7ConfigPaths) {
        Get-SingleRegexCapture -Path $path -Pattern $context7PackagePattern -GroupName "version" -Label "Context7 config example"
    }
) | Where-Object { $_ }

$uniqueContext7Tested = @($context7TestedVersions | Sort-Object -Unique)
$uniqueContext7Latest = @($context7LatestVersions | Sort-Object -Unique)
$uniqueContext7Pinned = @($context7PinnedVersions | Sort-Object -Unique)
if ($uniqueContext7Tested.Count -ne 1 -or $uniqueContext7Latest.Count -ne 1 -or $uniqueContext7Pinned.Count -ne 1) {
    Add-Failure "Context7 version mismatch across compatibility documents or configuration examples."
}
elseif ($uniqueContext7Tested[0] -ne $uniqueContext7Pinned[0]) {
    Add-Failure "Context7 version mismatch: config examples pin $($uniqueContext7Pinned[0]) but compatibility documents identify $($uniqueContext7Tested[0]) as tested."
}

$tmpPolicyPath = Join-Path $root ".tmp/README.md"
if (-not (Test-Path -LiteralPath $tmpPolicyPath)) {
    Add-Failure "Missing .tmp permanent/local boundary policy: $tmpPolicyPath"
}
else {
    $tmpPolicyText = Get-Content -LiteralPath $tmpPolicyPath -Raw
    foreach ($marker in @("not a blanket disposable directory", ".tmp/local/", "authoritative documents", "credentials", "only copy")) {
        if ($tmpPolicyText.IndexOf($marker, [System.StringComparison]::OrdinalIgnoreCase) -lt 0) {
            Add-Failure ".tmp boundary policy is missing '$marker': $tmpPolicyPath"
        }
    }
}
$gitignorePath = Join-Path $root ".gitignore"
if (-not (Test-Path -LiteralPath $gitignorePath)) {
    Add-Failure "Missing repository ignore policy: $gitignorePath"
}
else {
    $gitignoreLines = @(Get-Content -LiteralPath $gitignorePath | ForEach-Object { $_.Trim() })
    if ($gitignoreLines -notcontains ".tmp/local/") {
        Add-Failure ".gitignore must reserve .tmp/local/ for ignored task-local data: $gitignorePath"
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
