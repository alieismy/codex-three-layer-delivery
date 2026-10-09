# Claude instructions for Opus 5.5

Date: 2026-10-09. Status: three guidance-driven edits applied to the Claude global template after a bounded A/B smoke test; not yet released.

## Decision and scope

Most of the Claude-facing instructions already match the current Opus 5.5 guidance. The global template had no all-caps emphasis, no request to write out reasoning, tight scope controls, and Skill descriptions and progressive loading within the documented limits. The evidence supported three targeted edits to `claude/global/CLAUDE.md` and its Simplified Chinese mirror:

| ID | Change | Guidance basis |
|---|---|---|
| R1 | The subagent rule drops "counterexample review" and adds: do not use subagents to verify or double-check your own work unless the user asks for an independent review | The Opus 5 prompting page advises against using subagents to verify the model's own work |
| R2 | Remove the eight-item "Pre-Output Self-Review" section | Opus 5 checks its own work without prompting; explicit re-check instructions cause over-verification. Five of the eight items repeated existing rules almost verbatim, and the other three partly overlapped |
| R3 | Remove Thinking Methods items 1–3 (first-principles decomposition, task classification, multi-perspective reasoning); keep counterargument testing, critical evaluation, and confidence labeling as items 1–3 | Prescribed thinking steps are less effective than general instructions, and effort is the primary control for thinking depth. The retained items define output requirements, not thinking steps |

The always-on global text shrank from 18,438 to 17,137 bytes (−7.1%) and from 152 to 138 lines.

**Unchanged:**
- `claude/project/CLAUDE.md`, the imported `AGENTS.md`, and the nine `rd-*` Skills. In the Skills, "verify" refers to verifiable deliverables such as acceptance criteria and verification actions, not to the model re-checking itself.
- Codex and Cursor surfaces, by maintainer instruction. `codex/global/AGENTS.md` still contains the removed sections; this divergence is intentional because the guidance is Claude-specific.
- Effort settings. Neither the templates nor the Skills set an effort level.

**Strongest objection:** one sample per cell cannot show an improvement. The test shows only that the frozen assertions detected no regression. The edits are adopted because they follow the published guidance, remove duplicated or prescriptive text that no validator depends on, and are reversible. Confidence that the edits do not degrade quality is medium; there is no evidence that they improve it.

## Official guidance and application

Pages were read on 2026-10-09. The Opus 5.5 page describes the Opus 5 prompting patterns as a reasonable starting point, so the Opus 5 guidance is applied here by inheritance. That is an inference, not a separate Opus 5.5 statement.

| # | Guidance | Repository state before this change | Disposition | Confidence |
|---|---|---|---|---|
| 1 | Effort is the primary, more reliable lever for thinking depth. The default is `medium`; at `xhigh`/`max`, Opus 5.5 thinks more than Opus 5 at the same level. Use `xhigh`/`max` only where they show a measured quality gain | The templates set no effort | No change. Skill `effort` frontmatter is **not** recommended: it overrides the session level, so `high` would lower a session running at `xhigh`, and whether a claude.ai upload preserves the field is unknown | High |
| 2 | Instructions such as "think carefully" in chat system prompts can be removed. General instructions work better than prescribed step-by-step thinking | Thinking Methods items 1–3 prescribed the thinking process; item 2 listed 14 task types with no following action | R3 | Medium |
| 3 | Opus 5 self-checks without prompting; explicit re-check instructions cause over-verification and should be removed | The eight-item Pre-Output Self-Review, five of whose items duplicated existing rules | R2 | Medium |
| 4 | Do not use subagents to verify or double-check the model's own work | The subagent rule listed "counterexample review" as a subagent use | R1 | Medium-high |
| 5 | Unattended runs can stop early; naming the specific stop patterns helps, but this supplement should not be used in interactive sessions | The template already says to continue when the next step is implied | No change. Revisit only if early stopping is observed in unattended runs | Medium |
| 6 | Progress updates and pasted-content markers are harness-side behavior | Observed in Claude Code CLI `2.1.295` in the authoring session | No change; do not add rules limiting progress updates | High (one session) |
| 7 | Asking the model to write out its reasoning in the response can trigger `reasoning_extraction` refusals | No such instruction; the template says not to reproduce every internal check | No change | High |
| 8 | Claude Code memory guidance: keep each `CLAUDE.md` under 200 lines with specific, consistent instructions. `CLAUDE.md` is delivered as a user message, and `/doctor prompt-audit` can check instructions written for older models | 152 global lines (now 138); 111 lines in `AGENTS.md` | No structural change. `/doctor prompt-audit` was not run on the installed CLI and remains unverified | Medium |
| 9 | Skill authoring: descriptions up to 1,024 characters, `SKILL.md` under 500 lines, references one level deep, no over-explaining for Opus, evaluation-driven iteration | Descriptions of 345–460 characters, 104–162 lines, one-level references | No structural change. Gap: Claude-side tests covered Skill selection and loading only; the A/B below is the first Opus 5.5 output-quality check, and it is small | High |
| 10 | Literal-scope wording such as "only report high-severity issues" lowers recall (stated for code review) | `rd-review` excludes pure style issues and requires location, evidence, and impact for each finding | Recorded as a hypothesis only; no change | Low |

Vision, frontend, multi-application exploration, multi-agent timing signals, thinking-disabled prompts, and API breaking changes do not apply to this repository's document-delivery scope and were not assessed.

## A/B smoke test

**Design**, frozen before execution:
- **Runs:** four existing eval tasks × three arms × one sample = 12 headless `claude -p` runs. Model `claude-opus-5-5` at `xhigh` effort, Claude Code CLI `2.1.295`, random order.
- **Arms:**
  - A0: the template at base commit `3b70e0f`
  - A1: A0 plus R1
  - A2: A1 plus R2 and R3
- **Tasks:**
  - T1: `rd-review` eval 7, pressure to accept unverified Critical severities
  - T2: `rd-writing` eval 4, a decision brief of at most 220 words
  - T3: `rd-research` eval 7, a static-evidence overclaim under time pressure
  - T4: `rd-feasibility` eval 4, a bounded-pilot recommendation
- **Isolation:**
  - Each run used a fresh fixture project. The arm text was loaded as a project rule (`.claude/rules/global-directives.md`), next to the project adapter, the imported `AGENTS.md`, and the nine Skills.
  - `--setting-sources project,local` excluded the user-level `CLAUDE.md`.
  - Tools were read-only, with no web access and no MCP servers.
  - Two `claude-haiku-5-5` probes confirmed the loaded instruction files, the restricted tools, and Skill visibility before the Opus runs.
- **Assertions:** each eval's own assertions, plus three global ones:
  - G1: no subagent used to verify the model's own work
  - G2: leads with the conclusion
  - G3: confidence or uncertainty labels, for T1, T3, and T4
- **Blinding:** outputs were graded under random sample IDs before the arm mapping was opened.
- **Decision rule:**
  - R1 passes if A1 adds no failure that A0 passed.
  - R2 and R3 are adopted if A2 passes at least as many assertions as A1 and adds no failure that A1 passed.
  - A new failure would trigger one repeat run per affected task.

**Assertions passed:**

| Task | A0 | A1 | A2 |
|---|---:|---:|---:|
| T1 review | 7/7 | 7/7 | 7/7 |
| T2 brief | 6/7 | 6/7 | 6/7 |
| T3 research | 7/7 | 7/7 | 7/7 |
| T4 feasibility | 8/8 | 8/8 | 8/8 |
| **Total** | **28/29** | **28/29** | **28/29** |

Both decision rules passed and no repeat runs were triggered. The edited English template is byte-identical to arm A2.

**Efficiency, reported but not used as a gate:**

| Arm | Output tokens | Thinking tokens | Duration (s) | CLI-reported cost (USD) | Response words |
|---|---:|---:|---:|---:|---:|
| A0 | 32,513 | 24,384 | 325.4 | 1.40 | 3,146 |
| A1 | 23,428 | 16,552 | 234.8 | 1.21 | 2,710 |
| A2 | 27,101 | 19,621 | 286.6 | 1.28 | 3,023 |

A1 and A2 used fewer output tokens than A0, but one sample per cell cannot separate an instruction effect from run-to-run variance. T4 alone ranged from 7,951 output tokens (A1) to 13,830 (A2). No efficiency claim is made.

**Observations:**
- **T2 length overrun in every arm.** The briefs ran to 250, 240, and 238 words (A0, A1, A2), counted as whitespace-separated words before the trailing note, against a 220-word limit. Each response reported its length as about 200–205 words. This shared baseline defect does not distinguish the arms; it is a follow-up candidate for `rd-writing`.
- **G1 did not discriminate.** No arm made any subagent call, so R1 rests on the guidance, not on an observed change in behavior.
- **T3 Skill use.** No arm invoked `rd-research` for T3, yet all three passed.
- **T1 severity.** The A0 sample escalated one finding to Critical and rejected the deliverable; the A1 and A2 samples kept it Major and approved conditionally. All three met the assertions. A single sample does not support attributing the difference to an arm.

## Limits

- One sample per cell; the results are not reliability estimates.
- The experimenting agent graded its own experiment. Hidden sample IDs reduce bias, but the grading is not independent.
- The global text loaded as a project rule, not from the user-level memory slot. The slot was the same in all arms.
- Synthetic English tasks only; the Chinese mirror was not run.
- Concurrent `InstructionsLoaded` hook writes on Windows lost one load record in each of two runs. The surviving records still show the instruction chain loaded, and model results were unaffected.
- Costs are the CLI's `total_cost_usd` values, about USD 3.89 for the 12 Opus runs and about USD 0.011 for the two Haiku probes, not billing records.
- Existing personal installations keep the previous text until they are reinstalled by following the [installation guide](installation.md).

The [evidence record](evidence/opus-5-5-instruction-ab-2026-10-09.json) contains the arm hashes, the probes, the frozen prompts and assertions, every full response with its hash, the grades, and the metrics.

## Deferred items and re-entry conditions

| Item | Status | Reopen when |
|---|---|---|
| Effort note in `claude/README.md`. A top-level user `effortLevel` does not apply to Opus 5.5; use `/effort` or per-model `modelSettings` | Deferred, not approved | Downstream users report effort-setting confusion |
| Skill `effort` frontmatter | Rejected | A per-Skill quality gain is measured and claude.ai retention of the field is confirmed |
| Early-stop prompt guidance | Not added | Early stopping is observed in unattended runs |
| T2 word-limit overrun | Recorded | It reproduces with at least two samples and a candidate `rd-writing` change is tested |
| `/doctor prompt-audit` cross-check | Not run | The command is confirmed on the installed CLI |
| Personal effort level | Outside repository scope. Choosing between `high` and `xhigh` is a cost and latency trade-off; no workload measurement exists here | A maintainer measures their own workload |

## Sources

Official documentation, read on 2026-10-09:
- [What's new in Claude Opus 5.5](https://platform.claude.com/docs/en/models/opus-5-5/whats-new-opus-5-5)
- [Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5)
- [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5)
- [Effort](https://platform.claude.com/docs/en/build-with-claude/effort)
- [Claude Code model configuration](https://code.claude.com/docs/en/model-config), [Skills](https://code.claude.com/docs/en/skills), and [memory](https://code.claude.com/docs/en/memory)
- [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

Secondary sources, used as background only; they did not contradict the official guidance, and no conclusion depends on them:
- [KDnuggets](https://www.kdnuggets.com/everything-claude-opus-5-5-actually-ships-with)
- [ForkLog](https://forklog.com/en/news/anthropic-launches-claude-opus-5-5)
- [Kiro changelog](https://kiro.dev/changelog/models/claude-opus-5-5/)
- [Developers Digest](https://www.developersdigest.tech/blog/opus-5-5-claude-code-playbook-2026)
- [claudefa.st](https://claudefa.st/blog/guide/development/opus-5-5-best-practices)
- [Nicolas Deville's notes](https://notes.nicolasdeville.com/ai/opus-5-5-best-practices/)
