[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$trimChars = [char[]]@(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
)
$systemTempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd($trimChars)
$runRoot = Join-Path $systemTempRoot ("codex-three-layer-validator-{0}" -f [guid]::NewGuid().ToString("N"))
$pwshPath = (Get-Command pwsh -ErrorAction Stop).Source
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Set-LfText {
    param(
        [string]$Path,
        [string]$Content
    )

    $normalized = $Content.Replace("`r`n", "`n").Replace("`r", "`n")
    [System.IO.File]::WriteAllText($Path, $normalized, $utf8NoBom)
}

function Copy-RepositoryForCase {
    param([string]$Destination)

    New-Item -ItemType Directory -Path $Destination | Out-Null
    foreach ($item in Get-ChildItem -LiteralPath $repoRoot -Force) {
        if ($item.Name -eq ".git") {
            continue
        }
        if ($item.Name -eq ".tmp") {
            $tmpDestination = Join-Path $Destination ".tmp"
            New-Item -ItemType Directory -Path $tmpDestination | Out-Null
            foreach ($tmpItem in Get-ChildItem -LiteralPath $item.FullName -Force) {
                if ($tmpItem.Name -ne "local") {
                    Copy-Item -LiteralPath $tmpItem.FullName -Destination $tmpDestination -Recurse -Force
                }
            }
            continue
        }

        Copy-Item -LiteralPath $item.FullName -Destination $Destination -Recurse -Force
    }
}

function Invoke-NegativeCase {
    param(
        [string]$Name,
        [scriptblock]$Mutate,
        [string[]]$ExpectedPattern
    )

    $caseRoot = Join-Path $runRoot $Name
    Copy-RepositoryForCase -Destination $caseRoot
    & $Mutate $caseRoot

    $validatorPath = Join-Path $caseRoot "scripts/validate.ps1"
    $output = (& $pwshPath -NoProfile -File $validatorPath 2>&1 | Out-String)
    $exitCode = $LASTEXITCODE
    if ($exitCode -eq 0) {
        throw "Negative validator case '$Name' unexpectedly passed."
    }
    foreach ($pattern in $ExpectedPattern) {
        if ($output -notmatch $pattern) {
            throw "Negative validator case '$Name' did not report expected pattern '$pattern'.`n$output"
        }
    }

    Write-Host "Negative case passed: $Name" -ForegroundColor Green
}

New-Item -ItemType Directory -Path $runRoot | Out-Null
try {
    Invoke-NegativeCase -Name "criterion-distribution" -ExpectedPattern "Each numbered Skill step must contain exactly one completion criterion" -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "skills/rd-research/SKILL.md"
        $content = Get-Content -LiteralPath $path -Raw
        $stepMatches = [regex]::Matches($content, "(?m)^### \d+\..*$")
        if ($stepMatches.Count -lt 3) {
            throw "Fixture requires at least three numbered steps."
        }

        $step2Start = $stepMatches[1].Index
        $step3Start = $stepMatches[2].Index
        $step2Segment = $content.Substring($step2Start, $step3Start - $step2Start)
        $criterion = [regex]::Match($step2Segment, "(?m)^\*\*Completion criterion:\*\*.*(?:\n|$)")
        if (-not $criterion.Success) {
            throw "Fixture could not locate the second-step completion criterion."
        }

        $criterionStart = $step2Start + $criterion.Index
        $mutated = $content.Remove($criterionStart, $criterion.Length)
        $mutated = $mutated.Insert($step2Start, $criterion.Value)
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "context7-version-mismatch" -ExpectedPattern "Context7 version mismatch" -Mutate {
        param($caseRoot)

        $paths = @(
            "codex/examples/config.example.toml",
            "zh-CN/codex/examples/config.example.toml",
            "cursor/project/.cursor/mcp.example.json",
            "cursor/zh-CN/.cursor/mcp.example.json"
        )
        foreach ($relativePath in $paths) {
            $path = Join-Path $caseRoot $relativePath
            $content = Get-Content -LiteralPath $path -Raw
            $pinMatches = [regex]::Matches($content, "@upstash/context7-mcp@[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?")
            if ($pinMatches.Count -ne 1) {
                throw "Fixture requires exactly one Context7 package pin in $relativePath."
            }
            $mutated = [regex]::Replace(
                $content,
                "@upstash/context7-mcp@[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?",
                "@upstash/context7-mcp@99.99.99"
            )
            Set-LfText -Path $path -Content $mutated
        }
    }

    Invoke-NegativeCase -Name "delivery-invocation-policy" -ExpectedPattern "rd-delivery adapters must disable model invocation" -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "cursor/project/.cursor/skills/rd-delivery/SKILL.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content -replace "(?m)^disable-model-invocation:\s*true\n", ""
        if ($mutated -eq $content) {
            throw "Fixture could not remove the rd-delivery invocation policy."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "evidence-surface-contract" -ExpectedPattern @(
        "Evidence-contract surface is missing 'final generated or effective configuration'",
        "Evidence-contract surface must allow a supported no-change conclusion"
    ) -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "codex/project/AGENTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content.Replace("final generated or effective configuration, ", "")
        $mutated = [regex]::Replace(
            $mutated,
            "(?m)^- If the available evidence does not justify a modification, record a bounded no-change conclusion.*\n",
            ""
        )
        if ($mutated -eq $content -or $mutated.Contains("final generated or effective configuration") -or $mutated.Contains("no-change")) {
            throw "Fixture could not remove the complete evidence/no-change surface contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "rd-specialist-evidence-contract" -ExpectedPattern @(
        "RD specialist contract is missing 'final generated or effective configuration'",
        "rd-research must include the evidence-boundary/no-change output eval",
        "rd-research trigger evals must keep the approved-fix implementation near-miss negative"
    ) -Mutate {
        param($caseRoot)

        $skillPath = Join-Path $caseRoot "skills/rd-research/SKILL.md"
        $skillContent = Get-Content -LiteralPath $skillPath -Raw
        $mutatedSkill = $skillContent.Replace("final generated or effective configuration, ", "")
        if ($mutatedSkill -eq $skillContent) {
            throw "Fixture could not remove the RD specialist evidence state."
        }
        Set-LfText -Path $skillPath -Content $mutatedSkill

        $evalPath = Join-Path $caseRoot "skills/rd-research/evals/evals.json"
        $evalDocument = Get-Content -LiteralPath $evalPath -Raw | ConvertFrom-Json
        $remainingEvals = @($evalDocument.evals | Where-Object { $_.id -ne 5 })
        if ($remainingEvals.Count -ne (@($evalDocument.evals).Count - 1)) {
            throw "Fixture could not remove the evidence-boundary output eval."
        }
        $evalDocument.evals = $remainingEvals
        Set-LfText -Path $evalPath -Content ($evalDocument | ConvertTo-Json -Depth 20 -Compress)

        $triggerPath = Join-Path $caseRoot "skills/rd-research/evals/trigger-evals.json"
        $triggers = @(Get-Content -LiteralPath $triggerPath -Raw | ConvertFrom-Json)
        $nearMiss = @($triggers | Where-Object { $_.query -match "verified and approved" })
        if ($nearMiss.Count -ne 1 -or $nearMiss[0].should_trigger -ne $false) {
            throw "Fixture could not locate the implementation near-miss trigger eval."
        }
        $nearMiss[0].should_trigger = $true
        Set-LfText -Path $triggerPath -Content ($triggers | ConvertTo-Json -Depth 20 -Compress)
    }

    Invoke-NegativeCase -Name "global-implementation-discipline" -ExpectedPattern @(
        "Global AGENTS\.md is missing required routing or fallback heading '## Implementation Discipline'",
        "Global AGENTS\.md is missing required always-on behavior 'Personal Global Instructions \(v7\.7\)'",
        "Global AGENTS\.md is missing required always-on behavior 'initial request and the initial interpretation may both be incomplete'",
        "Global AGENTS\.md is missing required always-on behavior 'Do not add speculative features, extension points, abstractions, pass-through layers, or dependencies'",
        "Global AGENTS\.md is missing required always-on behavior 'same domain concept and is expected to change for the same reason'",
        "Global AGENTS\.md is missing required always-on behavior 'Use names that convey domain roles at the scope where ambiguity matters'",
        "Global AGENTS\.md is missing required always-on behavior 'Validate and normalize untrusted or weakly typed data at trust or representation boundaries'",
        "Global AGENTS\.md is missing required always-on behavior 'Once a domain value establishes its invariants, rely on them within the same trusted component'",
        "Global AGENTS\.md is missing required always-on behavior 'Avoid boolean flags that select materially different behavior or create hidden modes'",
        "Global AGENTS\.md is missing required always-on behavior 'Public API documentation still describes the contract'",
        "Global AGENTS\.md is missing required always-on behavior 'Preserve uncommitted user or third-party work'",
        "Global AGENTS\.md is missing required always-on behavior 'Do not remove or change existing behavior, compatibility, or instruction surfaces unless the request or an approved design requires it'",
        "Global AGENTS\.md is missing required always-on behavior 'other instruction files as scope-sensitive; make only required companion updates and report them'",
        "Global AGENTS\.md is missing required always-on behavior 'When validation fails, determine whether the current change introduced it'",
        "Global AGENTS\.md is missing required always-on behavior 'report pre-existing or unrelated failures without silently expanding scope'",
        "Global AGENTS\.md is missing required routing or fallback heading '## 实现纪律'",
        "Global AGENTS\.md is missing required always-on behavior '个人全局指令（v7\.7）'",
        "Global AGENTS\.md is missing required always-on behavior '初始诉求和首次理解都可能不完整'",
        "Global AGENTS\.md is missing required always-on behavior '不添加投机性功能、扩展点、抽象、透传层或依赖'",
        "Global AGENTS\.md is missing required always-on behavior '同一领域概念且预计会因同一原因变化'",
        "Global AGENTS\.md is missing required always-on behavior '在歧义会影响理解的作用域使用能表达领域角色的名称'",
        "Global AGENTS\.md is missing required always-on behavior '在信任边界或表示边界验证并规范化不可信或弱类型数据'",
        "Global AGENTS\.md is missing required always-on behavior '领域值一旦建立不变量，同一可信组件内部应依赖这些不变量'",
        "Global AGENTS\.md is missing required always-on behavior '避免使用会选择实质不同的行为或创建隐藏模式的 boolean flag'",
        "Global AGENTS\.md is missing required always-on behavior '公共 API 文档仍应说明契约'",
        "Global AGENTS\.md is missing required always-on behavior '保留用户或第三方的未提交工作'",
        "Global AGENTS\.md is missing required always-on behavior '当前请求或已批准设计未要求时，不得移除或改变既有行为、兼容性或指令面'",
        "Global AGENTS\.md is missing required always-on behavior '等指令文件时，只执行批准范围和必要的一致性同步，并单独汇报'",
        "Global AGENTS\.md is missing required always-on behavior '验证失败时先判断是否由本次改动引入'",
        "Global AGENTS\.md is missing required always-on behavior '对既存或无关失败准确报告，不静默扩大范围'"
    ) -Mutate {
        param($caseRoot)

        $surfaces = @(
            @{
                Path = "codex/global/AGENTS.md"
                Version = "Personal Global Instructions (v7.7)"
                OldVersion = "Personal Global Instructions (v7.6)"
                Section = "(?ms)^## Implementation Discipline\n\n.*?(?=^## Repository and Editing Discipline)"
                Interaction = "(?m)^- Assume the initial request and the initial interpretation may both be incomplete\..*\n"
                Worktree = "(?m)^- Preserve uncommitted user or third-party work\..*\n"
                Behavior = "(?m)^- Do not remove or change existing behavior, compatibility, or instruction surfaces unless the request or an approved design requires it\..*\n"
                Validation = "(?m)^- When validation fails, determine whether the current change introduced it\..*\n"
                RequiredAbsent = @(
                    "## Implementation Discipline",
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
                    "report pre-existing or unrelated failures without silently expanding scope"
                )
            },
            @{
                Path = "zh-CN/codex/global/AGENTS.md"
                Version = "个人全局指令（v7.7）"
                OldVersion = "个人全局指令（v7.6）"
                Section = "(?ms)^## 实现纪律\n\n.*?(?=^## 仓库与编辑纪律)"
                Interaction = "(?m)^- 假设初始诉求和首次理解都可能不完整。.*\n"
                Worktree = "(?m)^- 保留用户或第三方的未提交工作。.*\n"
                Behavior = "(?m)^- 当前请求或已批准设计未要求时，不得移除或改变既有行为、兼容性或指令面。.*\n"
                Validation = "(?m)^- 验证失败时先判断是否由本次改动引入。.*\n"
                RequiredAbsent = @(
                    "## 实现纪律",
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
                    "对既存或无关失败准确报告，不静默扩大范围"
                )
            }
        )

        foreach ($surface in $surfaces) {
            $path = Join-Path $caseRoot $surface.Path
            $content = Get-Content -LiteralPath $path -Raw
            $mutated = $content.Replace($surface.Version, $surface.OldVersion)
            $mutated = [regex]::Replace($mutated, $surface.Section, "")
            $mutated = [regex]::Replace($mutated, $surface.Interaction, "")
            $mutated = [regex]::Replace($mutated, $surface.Worktree, "")
            $mutated = [regex]::Replace($mutated, $surface.Behavior, "")
            $mutated = [regex]::Replace($mutated, $surface.Validation, "")
            if ($mutated -eq $content -or $mutated.Contains($surface.Version)) {
                throw "Fixture could not remove the versioned implementation contract from $($surface.Path)."
            }
            foreach ($marker in $surface.RequiredAbsent) {
                if ($mutated.Contains($marker)) {
                    throw "Fixture left implementation marker '$marker' in $($surface.Path)."
                }
            }
            Set-LfText -Path $path -Content $mutated
        }
    }

    Invoke-NegativeCase -Name "global-execution-efficiency-contract" -ExpectedPattern "Global AGENTS\.md is missing required always-on behavior 'do not start another model turn solely to repeat it'" -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "codex/global/AGENTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $marker = "do not start another model turn solely to repeat it"
        $mutated = $content.Replace($marker, "a later model turn may repeat the same wait")
        if ($mutated -eq $content -or $mutated.Contains($marker)) {
            throw "Fixture could not remove the execution-efficiency wait contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "root-agents-missing" -ExpectedPattern "Missing repository-root maintainer AGENTS\.md" -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "AGENTS.md"
        if (-not (Test-Path -LiteralPath $path)) {
            throw "Fixture requires the repository-root maintainer AGENTS.md."
        }
        Remove-Item -LiteralPath $path -Force
    }

    Invoke-NegativeCase -Name "root-agents-maintainer-contract" -ExpectedPattern "Repository-root maintainer AGENTS\.md is missing required contract 'The English root is the canonical baseline'" -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "AGENTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content.Replace(
            "The English root is the canonical baseline.",
            "English sources provide the initial material."
        )
        if ($mutated -eq $content -or $mutated.Contains("The English root is the canonical baseline")) {
            throw "Fixture could not remove the root maintainer authority contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "context-reuse-invalidation-contract" -ExpectedPattern @(
        "Context-reuse surface is missing 'context compaction'",
        "Context-reuse surface is missing 'first meaningful checkpoint'",
        "Context-reuse surface is missing 'task plan or delivery record'"
    ) -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "codex/project/AGENTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content.Replace("context compaction", "context reduction")
        $mutated = $mutated.Replace("first meaningful checkpoint", "initial update")
        $mutated = $mutated.Replace("task plan or delivery record", "task-specific state record")
        if (
            $mutated -eq $content -or
            $mutated.Contains("context compaction") -or
            $mutated.Contains("first meaningful checkpoint") -or
            $mutated.Contains("task plan or delivery record")
        ) {
            throw "Fixture could not remove the complete context-reuse invalidation contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "greenfield-research-gate" -ExpectedPattern @(
        "Greenfield research-gate surface is missing 'GitHub is a candidate source, not the sole authority\.'",
        "Greenfield research-gate surface is missing 'Implementation is outside the RD Skills' delivery boundary'"
    ) -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "PROMPTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content.Replace("GitHub is a candidate source, not the sole authority.", "GitHub provides the source list.")
        $mutated = $mutated.Replace("Implementation is outside the RD Skills' delivery boundary", "Implementation follows later")
        if (
            $mutated -eq $content -or
            $mutated.Contains("GitHub is a candidate source, not the sole authority.") -or
            $mutated.Contains("Implementation is outside the RD Skills' delivery boundary")
        ) {
            throw "Fixture could not remove the complete greenfield research/approval contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "adversarial-clarification-preamble" -ExpectedPattern @(
        "Adversarial clarification-preamble surface is missing 'This is an optional preamble, not a standalone Skill\.'",
        "Adversarial clarification-preamble surface is missing 'Do not manufacture symmetry'",
        "Adversarial clarification-preamble surface is missing 'If exactly one unresolved decision that only I can make blocks the final judgment'"
    ) -Mutate {
        param($caseRoot)

        $path = Join-Path $caseRoot "PROMPTS.md"
        $content = Get-Content -LiteralPath $path -Raw
        $mutated = $content.Replace("This is an optional preamble, not a standalone Skill.", "This is a standalone mandatory workflow.")
        $mutated = $mutated.Replace("Do not manufacture symmetry", "Present both sides symmetrically")
        $mutated = $mutated.Replace("If exactly one unresolved decision that only I can make blocks the final judgment", "Before every final judgment")
        if (
            $mutated -eq $content -or
            $mutated.Contains("This is an optional preamble, not a standalone Skill.") -or
            $mutated.Contains("Do not manufacture symmetry") -or
            $mutated.Contains("If exactly one unresolved decision that only I can make blocks the final judgment")
        ) {
            throw "Fixture could not remove the complete adversarial clarification contract."
        }
        Set-LfText -Path $path -Content $mutated
    }

    Invoke-NegativeCase -Name "platform-configuration-contracts" -ExpectedPattern @(
        "Prompt platform/invocation contract is missing 'paste into Codex CLI or Codex App\.'",
        "Prompt platform/invocation contract is missing '可直接粘贴到 Codex CLI 或 Codex App。'",
        "Prompt platform/invocation contract is missing 'paste into Cursor or Claude Code\.'",
        "Prompt platform/invocation contract is missing '可直接粘贴到 Cursor 或 Claude Code。'",
        "Claude settings must not use deprecated includeCoAuthoredBy",
        "Claude settings is missing required deny permission 'Read\(\./secrets/\*\*\)'",
        "Claude settings is missing required ask permission 'Bash\(git commit \*\)'",
        "Cursor Project Rules must use \.mdc",
        "Cursor guidance incorrectly allows plain \.md Project Rules",
        "Context7 API key must not be passed in Cursor MCP command arguments",
        "Global Bash Skill install must create ~/\.agents/skills before copying"
    ) -Mutate {
        param($caseRoot)

        $promptMutations = @(
            @{
                Path = "PROMPTS.md"
                Current = "paste into Codex CLI or Codex App."
                Invalid = "paste into Codex CLI, Codex App, Cursor, or Claude Code."
            },
            @{
                Path = "zh-CN/PROMPTS.md"
                Current = "可直接粘贴到 Codex CLI 或 Codex App。"
                Invalid = "可直接粘贴到 Codex CLI、Codex App、Cursor 或 Claude Code。"
            },
            @{
                Path = "cursor/project/PROMPTS.md"
                Current = "paste into Cursor or Claude Code."
                Invalid = "paste into Codex CLI, Codex App, Cursor, or Claude Code."
            },
            @{
                Path = "cursor/zh-CN/PROMPTS.md"
                Current = "可直接粘贴到 Cursor 或 Claude Code。"
                Invalid = "可直接粘贴到 Codex CLI、Codex App、Cursor 或 Claude Code。"
            }
        )
        foreach ($mutation in $promptMutations) {
            $path = Join-Path $caseRoot $mutation.Path
            $content = Get-Content -LiteralPath $path -Raw
            $mutated = $content.Replace($mutation.Current, $mutation.Invalid)
            if ($mutated -eq $content -or $mutated.Contains($mutation.Current)) {
                throw "Fixture could not break the prompt platform contract in $($mutation.Path)."
            }
            Set-LfText -Path $path -Content $mutated
        }

        $claudeSettingsPath = Join-Path $caseRoot "claude/project/.claude/settings.json"
        $claudeSettings = Get-Content -LiteralPath $claudeSettingsPath -Raw
        if (-not $claudeSettings.StartsWith("{`n")) {
            throw "Fixture requires LF-delimited Claude settings JSON."
        }
        $mutatedClaudeSettings = $claudeSettings.Insert(2, "  `"includeCoAuthoredBy`": false,`n")
        $mutatedClaudeSettings = $mutatedClaudeSettings.Replace("Read(./secrets/**)", "Read(./secrets/)")
        $mutatedClaudeSettings = $mutatedClaudeSettings.Replace("Bash(git commit *)", "Bash(git commit )")
        if (
            $mutatedClaudeSettings -eq $claudeSettings -or
            -not $mutatedClaudeSettings.Contains('"includeCoAuthoredBy"') -or
            $mutatedClaudeSettings.Contains("Read(./secrets/**)") -or
            $mutatedClaudeSettings.Contains("Bash(git commit *)")
        ) {
            throw "Fixture could not break the Claude permission and attribution contracts."
        }
        Set-LfText -Path $claudeSettingsPath -Content $mutatedClaudeSettings

        $invalidCursorRulePath = Join-Path $caseRoot "cursor/project/.cursor/rules/invalid.md"
        Set-LfText -Path $invalidCursorRulePath -Content "# Invalid plain Markdown Project Rule`n"

        $cursorReadmePath = Join-Path $caseRoot "cursor/README.md"
        $cursorReadme = Get-Content -LiteralPath $cursorReadmePath -Raw
        $validRuleClaim = 'Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance.'
        $invalidRuleClaim = 'Project Rules live in `.cursor/rules`; `.md` and `.mdc` are supported.'
        $mutatedCursorReadme = $cursorReadme.Replace($validRuleClaim, $invalidRuleClaim)
        if ($mutatedCursorReadme -eq $cursorReadme -or $mutatedCursorReadme.Contains($validRuleClaim)) {
            throw "Fixture could not break the Cursor rule-extension guidance contract."
        }
        Set-LfText -Path $cursorReadmePath -Content $mutatedCursorReadme

        $cursorMcpPath = Join-Path $caseRoot "cursor/project/.cursor/mcp.example.json"
        $cursorMcp = Get-Content -LiteralPath $cursorMcpPath -Raw
        $context7PackageArg = '        "@upstash/context7-mcp@4.0.2"'
        $context7KeyArgs = @(
            '        "@upstash/context7-mcp@4.0.2",',
            '        "--api-key",',
            '        "${env:CONTEXT7_API_KEY}"'
        ) -join "`n"
        $mutatedCursorMcp = $cursorMcp.Replace($context7PackageArg, $context7KeyArgs)
        if ($mutatedCursorMcp -eq $cursorMcp -or -not $mutatedCursorMcp.Contains('"--api-key"')) {
            throw "Fixture could not place the Context7 key in Cursor command arguments."
        }
        Set-LfText -Path $cursorMcpPath -Content $mutatedCursorMcp

        $readmePath = Join-Path $caseRoot "README.md"
        $readme = Get-Content -LiteralPath $readmePath -Raw
        $validGlobalInstall = "mkdir -p ~/.agents/skills`ncp -r skills/rd-* ~/.agents/skills/"
        $invalidGlobalInstall = "cp -r skills/rd-* ~/.agents/skills/"
        $mutatedReadme = $readme.Replace($validGlobalInstall, $invalidGlobalInstall)
        if ($mutatedReadme -eq $readme -or $mutatedReadme.Contains($validGlobalInstall)) {
            throw "Fixture could not remove the global Skill installation prerequisite."
        }
        Set-LfText -Path $readmePath -Content $mutatedReadme
    }

    Invoke-NegativeCase -Name "tmp-local-boundary" -ExpectedPattern @(
        "Missing .tmp permanent/local boundary policy",
        "\.gitignore must reserve \.tmp/local/"
    ) -Mutate {
        param($caseRoot)

        $policyPath = Join-Path $caseRoot ".tmp/README.md"
        if (-not (Test-Path -LiteralPath $policyPath)) {
            throw "Fixture requires the .tmp boundary policy."
        }
        Remove-Item -LiteralPath $policyPath -Force

        $gitignorePath = Join-Path $caseRoot ".gitignore"
        $gitignoreContent = Get-Content -LiteralPath $gitignorePath -Raw
        $mutatedGitignore = [regex]::Replace($gitignoreContent, "(?m)^\.tmp/local/\n", "")
        if ($mutatedGitignore -eq $gitignoreContent) {
            throw "Fixture could not remove the .tmp/local ignore boundary."
        }
        Set-LfText -Path $gitignorePath -Content $mutatedGitignore
    }

    Write-Host "Validator negative tests passed (14/14)." -ForegroundColor Green
}
finally {
    $resolvedRunRoot = [System.IO.Path]::GetFullPath($runRoot)
    $expectedPrefix = $systemTempRoot + [System.IO.Path]::DirectorySeparatorChar
    $leaf = Split-Path -Leaf $resolvedRunRoot
    $isWithinTemp = $resolvedRunRoot.StartsWith($expectedPrefix, [System.StringComparison]::OrdinalIgnoreCase)
    if (-not $isWithinTemp -or -not $leaf.StartsWith("codex-three-layer-validator-")) {
        throw "Refusing to remove an unverified temporary path: $resolvedRunRoot"
    }
    if (Test-Path -LiteralPath $resolvedRunRoot) {
        Remove-Item -LiteralPath $resolvedRunRoot -Recurse -Force
    }
}
