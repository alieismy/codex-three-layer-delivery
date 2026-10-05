# Forward-Looking RD Recommendations

Date: 2026-10-05. Status: implemented and locally checked; included in the `v1.8.1` release scope. Repository baseline: `63b0a458eda42cd8f726c217c37ed2bcd38d7a3d`. This record retains the pre-release implementation and behavior evidence; publication gates are reported separately in the release notes.

## Decision and Scope

The shared instructions now ask for credible opportunities, future evolution, and the opportunity cost of retaining the current approach when these can affect the requested decision. Recommendation strength follows the decision stage: exploration, bounded pilot, wider adoption, or production commitment. Evidence sufficient for a reversible pilot can justify recommending that pilot while production conditions remain unresolved.

This change implements an approved decision preference. The bounded comparison below does not establish that the previous instructions systematically suppressed innovation or that the new wording improves general model performance. Familiarity and novelty both remain subject to evidence, constraints, value, and authorization.

| Surface | Change |
|---|---|
| Global conduct and project completion | Add contextual opportunity seeking, stage-specific recommendations, adaptable workflow coverage, and bounded subagent work contracts. Keep mandatory sequences, completion criteria, source verification, and authority boundaries. |
| `rd-feasibility` | Compare opportunity costs and learning value, identify the relevant decision stage, and recommend supported trials with resource, success, stop, recovery, and expansion conditions. |
| `rd-solution` | Distinguish approved constraints from current practice; consider credible materially different approaches; separate target architecture, next recommendation, and immediate authorized scope. |
| `rd-research` | Add a conditional stage-aware evidence handoff; technology mode turns material unknowns into bounded verification proposals. |
| `rd-review` | Extend only feasibility and proposal review references to check stage fit, opportunity costs, and evidence for promising alternatives. |

The other five RD workflows remain unchanged. Skill descriptions, invocation policies, public model defaults, validator logic, and the maintainer `AGENTS.md` are unchanged by this work. Model selection stays in configuration. English sources were synchronized to Simplified Chinese and the applicable Claude Code and Cursor adapters; Claude project adapters remain thin imports. Cursor retains one always-applied rule and conditional specialist rules.

Three synthetic output cases were added: a supported pilot, unsupported production pressure, and a promising architecture under a fixed interface constraint. At this update's baseline, each canonical language tree contained 47 output cases. This inventory is separate from the selected behavior samples below; the later [upstream-learning pilot](upstream-learning-pilot.md) records its own additions and observations.

The approach is consistent with OpenAI's advice to focus instructions on intent, outcomes, and necessary constraints while avoiding excessive procedural control; that guidance motivates the design, not a claim about its measured benefit. See [Rethinking skills and prompts for GPT-6 Astra](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) and the [current model prompting guide](https://developers.openai.com/api/docs/guides/latest-model). Delegation remains subject to the host's actual capabilities and applicable authorization, consistent with the [subagent documentation](https://learn.chatgpt.com/docs/agent-configuration/subagents).

## Supplied-Text Comparison

The retained [evidence record](evidence/forward-looking-rd-2026-10-05.json) contains frozen instructions, synthetic records, prompts, requested model settings, final responses, hashes, and assertion dispositions. The runner used Codex CLI `0.160.0` with Astra `max` and Sol 6.1 `high`, baseline and candidate variants, five scenarios, and one response per cell. Inputs and assertions were frozen before sampling; baseline/candidate order was counterbalanced and timeout was 240 seconds per call. Each main cell retains its first response; the separate diagnostics below do not replace those results. Assertions were not given to the responding models.

| Requested setting | Variant | Pass | Partial / ambiguous | Fail |
|---|---|---:|---:|---:|
| `gpt-6-astra` / `max` | baseline | 21 | 1 | 0 |
| `gpt-6-astra` / `max` | candidate | 22 | 0 | 0 |
| `gpt-6.1-sol` / `high` | baseline | 21 | 1 | 0 |
| `gpt-6.1-sol` / `high` | candidate | 21 | 0 | 1 |

The scenarios cover a supported pilot, a promising processing architecture with a fixed interface, conflicting delegated summaries, an exact narrow requirements edit, and pressure for premature production commitment. Main-agent manual grading assessed all complete responses against the frozen assertions. An independent Sol 6.1 reviewer also scored the eight delegation and narrow-edit responses; its two ambiguous partial grades are retained. Scoring was not blinded, and the other twelve responses were not independently scored.

An earlier four-response diagnostic used an internally inconsistent fixture: 200 paired cases implied approximately 60 staff-hours at the supplied laboratory rates, exceeding its two-staff-day cap. All four responses identified the conflict. They remain in the evidence record, outside the corrected comparison. The fixture was changed to an 80 staff-hour cap, including setup, comparison, scoring, and recovery, and independent instruction-review fixes were incorporated before freezing the complete comparison. The remaining 16 cells in the initial manifest were never executed.

Across 20 completed main responses, conservative reporting gives **85 passed, two partial/ambiguous, and one failed assertion out of 88**. The Sol 6.1 candidate omitted the original `# Query PRD` title in the narrow-edit case. One separately recorded unchanged-input repeat preserved the complete excerpt; it does not erase the original failure or establish a fix. Both baseline delegation responses received an ambiguous partial under a strict reading of non-overlapping work: their independent reviewers rechecked technical claims. They can pass under an output-ownership interpretation allowing independent review overlap. This ambiguity is not evidence of a real delegation defect or candidate improvement.

The pilot, candidate-selection, and production-pressure scenarios satisfied their assertions in both instruction variants and both models. The evidence therefore supports the requested instruction preference with explicit limits; it does not establish general improvement or absence of regressions. Existing instructions already require full content preservation. No additional preservation rule or change to the other five workflows was made in response to the single variable output.

The strongest limitation is that the runner supplied English instruction text directly. Earlier same-host probes reported inherited personal global instructions despite isolation flags; those instructions were held at an unchanged hash throughout sampling. Complete context isolation and backend model identity were not independently attested. This does not test implicit Skill selection, native subagent delegation, Chinese prompt behavior, Claude/Cursor loading, a live deployment, or production acceptance. The delegation scenario asks for work packets and synthesis only.

## Review and Verification

An initial independent text review found three scope issues: a generic research path was constrained to technology mode and a narrow handoff; solution stage conditions lacked a corresponding input; pilot conditions were applied too broadly. All were corrected. A subsequent independent Sol 6.1 review confirmed closure and found no further material defect in the eight English source files. Two attempts to resume the earlier reviewer encountered model-capacity errors; these were execution failures, not review verdicts.

Repository `validate.ps1`, all **24/24** `test-validator.ps1` negative cases, and `git diff --check` passed. Skill Creator `quick_validate.py` passed for the four affected Skill payloads in each canonical language and the installed Chinese copies: **12 checks**. Mirror byte equality, unchanged unrelated Skill bodies and metadata, preservation of prior work, UTF-8/LF, references, and public-data hygiene were checked. The guarded private restore passed `-WhatIf`; no restoration was executed. The networked release gate was not run during that non-release implementation phase.

Private installed copies were synchronized separately with verified backups. Their paths and personal content are outside this public record. The existing model configuration was preserved. No commit, push, tag, or release was performed during that implementation phase. Future claims of improved decision quality require representative real tasks and outcome evidence beyond this small synthetic comparison.
