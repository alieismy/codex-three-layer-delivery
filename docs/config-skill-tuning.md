# Configuration and Skill tuning: bounded follow-up

Date: 2026-10-05. Status: scoped maintenance implemented; supplied-text pilot complete; native tool execution remains blocked.

Release scope: `v1.8.1`. This dated record retains the decisions and verification boundaries of the earlier configuration follow-up. The subsequent shared-instruction changes are recorded in [Forward-Looking RD Recommendations](forward-looking-rd.md).

## Decision and changes

Remove the retired `personality = "pragmatic"` setting from the English and Chinese public Codex examples. Clarify that the explorer description expresses a task constraint, while actual permissions inherit from the parent and depend on role configuration and runtime overrides. The official [changelog](https://learn.chatgpt.com/docs/changelog#codex-2026-09-22-gpt-6-sol-luna) and [subagent permission documentation](https://learn.chatgpt.com/docs/agent-configuration/subagents#approvals-and-sandbox-controls), inspected on this date, support these distinctions. Schema acceptance alone does not establish a setting's continuing effect or an enforced permission boundary.

Separately authorized personal maintenance narrowed the installed `hf-cli` description to explicit Hugging Face resources and operations, removed the same retired setting, corrected High-profile and MCP comments, disabled standalone Context7/Tavily in the base configuration, and added an opt-in `cli-research` profile that enables those two servers. Existing service definitions and credential references were preserved. A single personal governance clause now distinguishes deliberate memory edits from automatic generation, matching the existing public rule. These personal files and their verified backups are outside the repository.

At this earlier follow-up, the decision was to retain the existing Astra `max` / Plan `high` and Sol 5.6 `high` subagent defaults. The strongest argument for changing them is that Astra `xhigh` and Sol 6.1 met all declared content assertions here, while `max` took longer and Sol 5.6 missed two assertions. The counterweight is the narrow experiment: three English synthetic cases, one sample per setting, inherited personal instructions, and no native tool or actual subagent execution. This supports a broader Sol 6.1 trial, not a general migration or a lower-effort policy for architecture and standards work. The nine shared RD Skill bodies and public model defaults were unchanged by that follow-up.

## Supplied-text results

The [canonical evidence record](evidence/config-skill-tuning-2026-10-05.json) retains exact user-message prompts, workflow/source hashes, predeclared assertions, all responses and hashes, grades, diagnostics, usage, run order, and elapsed process times. No failed sample was replaced.

| Requested model / effort | Assertions | Cases passing every assertion | Total process time, three cases |
|---|---:|---:|---:|
| GPT-6 Astra / xhigh | 12/12 | 3/3 | 114.09 s |
| GPT-6 Astra / max | 12/12 | 3/3 | 181.75 s |
| GPT-5.6 Sol / high | 10/12 | 1/3 | 56.30 s |
| GPT-6.1 Sol / high | 12/12 | 3/3 | 76.78 s |

Cases reuse `rd-requirement` eval 5, `rd-review` eval 9, and `rd-writing` eval 4 at source revision `63b0a458`. Sol 5.6 omitted the original PRD title and the decision brief's synthetic provenance. All four authorized-pilot reviews preserved the original failure and completed without requesting the same approval again. Brief lengths were 213, 185, 211, and 211 whitespace-separated words in table order; all met the 220-word limit.

Astra `max` enclosed its PRD excerpt in a Markdown fence. Its excerpt content matches exactly, but its raw response does not. The evidence retains both checks. Treating an outer fence as presentation was a grading interpretation documented after execution, not a predeclared normalization rule. The primary content scores must not be presented as universal byte-for-byte preservation. Grading was performed by the task agent and was neither independent nor blinded.

The separate `hf-cli` description comparison supplied six routing requests: three Hugging Face tasks and three unrelated AI-requirements, academic-paper, and Amazon S3 tasks. The old description selected all six, matching 3/6 intended decisions; the candidate matched 6/6. This is a controlled decision from supplied metadata, not a measurement of live implicit Skill selection or its error rate. A fresh native `skills/list` call subsequently returned the new description with the Skill enabled and no loading errors.

## Execution and validation boundaries

Runs used Windows, CLI `0.160.0`, the requested `openai` provider, high verbosity, a fresh ephemeral process per sample, sequential execution, and a 240-second limit. Shell, web, discovered Skill instructions, apps, plugins, hooks, memories, and multi-agent features were disabled for scored samples. A context probe nevertheless reported the existing personal global `AGENTS.md`; it remained unchanged throughout the experiment. Exact user-message inputs are reproducible from the record, but the full inherited prompt context is not published or proven isolated. Backend model identity was not independently attested.

The native preflight agent reported automatic approval rejection of a read-only `Get-Content` command without a specific reason. No completed command-execution item or canary value was obtained. The underlying cause was not independently established, and permissions were not relaxed. Native Skill selection, file execution, tool efficiency, and actual subagent behavior therefore remain unverified. PowerShell shell-snapshot warnings occurred during text runs; all scored responses completed. The evidence also preserves a connection-prewarm warning in the metadata comparison. Process timings include startup/network effects and are not reliable speed rankings or cost measurements.

Personal verification used schema checks, strict base `app-server` loading and `config/read`, and native `mcp list` for base/profile enablement and inherited service definitions. CLI `0.160.0` rejects `--profile` for `app-server` and `--strict-config` for `mcp`; these are separate validation paths. An isolated candidate initially lacked two relative role files; adding hash-matched copies of those existing dependencies removed the warnings. Final base and profile checks completed without warnings. This establishes configuration loading, not a successful Context7/Tavily business call or Desktop reload.

Repository validation passed: `scripts/validate.ps1`, all 24 negative cases in `scripts/test-validator.ps1`, the live-schema/four-example strict-load checks in `scripts/validate-release.ps1`, and `git diff --check`. The first static run caught CRLF in the new evidence JSON; the writer was corrected to emit LF and validation passed on rerun. Integrity checks confirmed the narrow personal semantic changes, unchanged Hugging Face Skill body, verified originals, and public UTF-8/LF/privacy checks. The guarded restore script passed `-WhatIf`; an actual rollback was not executed. No commit, push, or release was performed during that maintenance phase.

## Remaining feedback and re-entry conditions

The inspected managed `.system/openai-docs/SKILL.md` requires official-document search before local inspection, including named local configuration questions. Proposed upstream refinement: use official sources first for product/API questions, and inspect the named local object first for target-environment diagnosis before checking its contract against current official sources. This is a static workflow-conflict candidate, not an established runtime defect. The managed Skill was not patched and no external feedback was sent.

Retain the personal experimental context-management flag pending evidence of its effect; do not distribute it as a public default. The installed Hugging Face Skill is marked as generated; recheck its description after future regeneration. Reopen model defaults after representative Chinese and complex real-task comparisons with a functioning authorized tool path. Reopen shared instruction edits only when a scoped candidate can be compared against a reproduced defect. This follow-up does not establish Desktop, Claude/Cursor, production, business, or release acceptance.
