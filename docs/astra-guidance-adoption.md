# Astra guidance: bounded adoption and behavior comparison

Date: 2026-09-20. Status: completed, bounded supplied-text comparison.

## Change and decision

This maintenance adds a source-linked explanation when a Skill or project instruction blocks requested work, plus an optional task authority/completion block in the prompt library. The baseline is `a88e15032061b496997a243d8c3094b84c8c510f`. Nine Skill bodies, descriptions, invocation policies, permission settings, and release authority are unchanged.

The rule belongs in [global conduct](../codex/global/AGENTS.md#working-mode); task-specific choices belong in the [optional prompt block](../PROMPTS.md#17-optional-authority-and-completion-contract). Chinese, Claude, and Cursor counterparts preserve the same contract and existing platform differences. Neither addition expands authority or makes stakeholder approval a prerequisite for completing every draft.

Retain both additions as an explicit public contract and an optional input format. The experiment found no candidate regression under its declared assertions, but does not establish a reliable improvement: the baseline already attributed the blocker in the first case, and the only score difference was an unreplicated synthetic-evidence label. Do not rewrite Skill bodies or claim reduced pauses, latency, tool use, or cost from these results.

## Source assessment

The three pages were fetched and read on 2026-09-20. Their URLs and response hashes are retained in the canonical [evidence record](evidence/astra-guidance-eval-2026-09-20.json); hashes identify the retrieved responses, not permanently available upstream versions.

| Source | Adopted mechanism and boundary |
|---|---|
| [OpenAI model guidance](https://developers.openai.com/api/docs/guides/latest-model?model=gpt-6-astra) | Make an instruction-caused pause traceable to the actual file and clause; continue independently authorized work. Model guidance does not replace project authority or permission controls. |
| [OpenAI: Rethinking skills and prompts](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) | Review instruction relevance and completion boundaries. Existing scoped reading and progressive disclosure remain; no observed routing defect justifies shortening every description or restructuring the Skills. |
| [PrompTessor prompting guide](https://promptessor.com/blog/gpt-6-astra-prompting-guide) | Adapt the separation of task authority, completion, and stopping into an optional block; compare behavior. This third-party synthesis is not independent confirmation of OpenAI's model claims or a reason to adopt its product. |

## Cases and results

Five English cases were run once per variant on Windows with `codex-cli 0.155.1`, requesting `gpt-6-astra` and `high` reasoning through the existing configured provider. Server-side model identity was not independently verified. The task agent read all ten final responses and graded the predeclared assertions; grading was neither independent nor blinded.

| Case | Controlled comparison | Baseline | Candidate |
|---|---|---|---|
| A1: retention decision blocked | Existing global text vs. one added rule; a synthetic policy requires owner approval, while two responsibilities can be documented | 5/5 | 5/5 |
| A2: authorized static assessment | Same rule comparison; reuse `rd-research` eval 6 and its fixture | 4/4 | 4/4 |
| A3: authorized pilot review | Same rule comparison; reuse `rd-review` eval 9 and its fixtures | 4/4 | 4/4 |
| B1: local PRD revision | Same five task conditions in prose vs. the optional block; reuse `rd-requirement` eval 5 | 4/4 | 4/4 |
| B2: finish a static evidence note | Same five task conditions in prose vs. the optional block; adapt the static-evidence fixture | 3/4 | 4/4 |
| Total assertion judgments | Five runs per variant | 20/21 | 21/21 |

B1 returned the exact same expected excerpt in both variants: only the threshold changed from 2 to 3 seconds; status and every other character were preserved. B2's baseline retained the no-change conclusion but omitted an explicit synthetic/fictional label, failing the predeclared compound assertion 4. The candidate included that label. The baseline failure remains in the record; it was not rescored under a weaker criterion or removed from the result.

All ten processes exited successfully, reported no error events, and recorded only `agent_message` completed items. This does not prove that attempted tool use would have been denied.

| Descriptive aggregate | Baseline | Candidate |
|---|---:|---:|
| Input tokens | 71,246 | 71,629 |
| Cached input tokens | 1,920 | 0 |
| Reported output tokens | 2,774 | 2,672 |
| Sum of elapsed seconds | 110.51 | 154.63 |

Timing and cache state varied; one candidate run took 55.13 seconds. These single observations do not establish a speed or cost benefit, and no provider-specific cost estimate is made.

## Method and reproduction

The existing [pilot method](agent-skills-pilot.md#method-and-reproduction) was reused. A context probe returned `none` for pre-existing user/project instructions and available Skills. The probe and configuration controls are not independent proof of the entire effective prompt or strong isolation.

The evidence record contains frozen input blocks, source paths and hashes, per-variant prompt recipes, complete final responses, response hashes, predeclared assertions, semantic grades and excerpts, usage, timing, and the actual run order. Expected answers and grading assertions were withheld from the model. A cases change only the new rule. B cases retain the baseline global rules and identical task conditions; the candidate adds the optional framing and field labels. The shared offline preamble instructs both variants to avoid tools, alongside the configured tool restrictions, so this cannot measure live tool-use economy.

To reconstruct and verify any retained prompt without calling a model:

```python
import hashlib
import json
from pathlib import Path

record = json.loads(Path("docs/evidence/astra-guidance-eval-2026-09-20.json").read_text(encoding="utf-8"))
case = record["cases"][0]  # Select another case if needed.
variant = "candidate"      # Or "baseline".
prompt = "\n\n".join(record["inputs"][key] for key in case["prompt_parts"][variant])
assert hashlib.sha256(prompt.encode("utf-8")).hexdigest() == case["prompt_sha256"][variant]
print(prompt, end="")
```

An authorized model rerun needs the recorded CLI flags and controls, an isolated temporary home and Git workspace, tools and discovered Skills disabled, and existing approved authentication. Private provider overrides and a child-only credential environment variable were used; no authentication file or credential was copied to the test home or public evidence. Run each prompt through stdin, retain the final response, and apply the recorded 240-second bound. The exact public inputs do not depend on ignored local files or access to the historical commit. The local execution driver is task-specific, not a new supported evaluation framework.

## Limits and re-entry conditions

The comparison covers explicitly supplied English text on one configured host. It does not establish native instruction loading, implicit Skill selection, reference discovery, full three-layer integration, Chinese behavior, Claude/Cursor behavior, permission enforcement, file-edit execution, live research, deployment, or business acceptance. Static mirror checks and repository gates establish separate text and repository contracts.

Reopen instruction changes for a reproduced, attributable failure. Reopen wider host, language, or routing evaluation when a relevant regression, public compatibility claim, or release decision requires it. Do not infer a general improvement from one extra passing assertion or remove project-inherent controls because a model is described as more capable.
