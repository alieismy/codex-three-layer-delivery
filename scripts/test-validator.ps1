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
            $matches = [regex]::Matches($content, "@upstash/context7-mcp@[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?")
            if ($matches.Count -ne 1) {
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

    Write-Host "Validator negative tests passed (6/6)." -ForegroundColor Green
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
