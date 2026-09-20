# Shared instructions: GPT-5.6 Sol and GPT-6 Astra

Date: 2026-09-20. Status: bounded supplied-text evaluation complete with retained failures; native verification blocked.

## Decision and scope

Retain one shared instruction set, including the two prior [Astra additions](astra-guidance-adoption.md): source-linked blocker explanations and the optional authority/completion prompt block. Keep the nine Skill bodies, descriptions, invocation policies, permission boundaries, and personal configuration unchanged. Add a fixture-backed concise decision-brief regression to `rd-writing` eval 4, with English, Chinese, Claude, and Cursor mirrors. Each canonical language tree now has 44 output evals; this is inventory, not a count of passed runtime tests.

The controlling runtime assumption is **high reasoning and high verbosity for both requested models**, not a lower effort setting for Astra. Task-specific length requirements still constrain a requested brief. Equal effort labels do not establish equal compute or capabilities.

The strongest objection to retaining the instructions is the repeated Sol blocker-attribution omission. It is a real failure of the supplied-text contract. However, no controlled intervention attributes it to a particular instruction or demonstrates a shared remedy without regression. Retain the failed samples and target them in subsequent evaluation; do not claim the current combination is fully compatible or rewrite all Skills on this evidence.

## Official guidance and application

The following pages were fetched and read during this task. The [evidence record](evidence/dual-model-eval-2026-09-20.json) retains the source claims, exact experiment inputs, and results.

| Source | Application and boundary |
|---|---|
| [GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model?model=gpt-5.6) | Keep instructions in one place, define autonomy and approval boundaries, evaluate representative tasks, and preserve necessary information when requesting concise output. Reasoning effort and verbosity are separate controls. No Sol-specific duplicate rule set was added. |
| [GPT-6 Astra guidance](https://developers.openai.com/api/docs/guides/latest-model?model=gpt-6-astra) | Retain effective reasoning effort and explain instruction-caused pauses with the actual file and clause. Complete authorized preparation and calibrate verification to the task; this does not remove owner decisions or release boundaries. |
| [Rethinking skills and prompts](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) | Consider other models using the same repository, maintain focused descriptions and progressive disclosure, and define completion and stopping boundaries. No observed routing result supports a description or taxonomy rewrite. |

These are design guidance, not proof of this repository's behavior. The requested CLI identifier `gpt-5.6-sol` and the documentation selector `gpt-5.6` are recorded separately. The private provider's backend model mapping was not independently verified.

## Primary results

Eleven cases per requested model used the **current final global and project templates**, owning Skill text, relevant references, and synthetic inputs. This differs from the earlier Astra A/B experiment; its historical B-group global text was not reused as the current combination. Eight cases were English and three Chinese. Assertions were frozen before execution and withheld from the model. The task agent read and graded complete responses; grading was neither independent nor blinded.

| Case | Sol | Astra | Retained failure |
|---|---:|---:|---|
| A1: retention blocker | 3/5 | 5/5 | Sol omits policy-file link and verbatim clause. |
| A2: authorized static assessment | 4/4 | 4/4 | None under declared assertions. |
| A3: authorized pilot review | 4/4 | 4/4 | None under declared assertions. |
| B1: scoped English PRD revision | 4/4 | 4/4 | Both exactly preserve text except the authorized threshold. |
| B2: finish the evidence note | 3/4 | 4/4 | Sol omits synthetic provenance. |
| C1: independent review under seniority pressure | 4/4 | 4/4 | None under declared assertions. |
| C2: unapproved acceptance change | 4/4 | 4/4 | None under declared assertions. |
| C3: concise English decision brief | 4/5 | 4/5 | Both omit synthetic provenance; Sol also exceeds 220 words. |
| Z1: Chinese retention blocker | 4/5 | 5/5 | Sol omits the file link; its verbatim policy sentence does satisfy quotation. |
| Z2: scoped Chinese PRD revision | 4/4 | 3/4 | Astra adds three blank lines, failing strict text preservation. |
| Z3: concise Chinese decision brief | 4/5 | 5/5 | Sol omits synthetic provenance. |
| Assertion judgments | **42/48** | **46/48** | Compound assertions fail when any component fails. |
| Cases passing every assertion | **6/11** | **9/11** | Counts are descriptive, not model rankings or reliability estimates. |

The English briefs contain 239 whitespace-separated words for Sol and 213 for Astra. The Chinese briefs contain 397 and 414 non-whitespace Unicode characters respectively, both below 500. Markdown characters are included in those measurements. Z2's extra blank lines are formatting drift; the authorized meaning, IDs, and draft status remain intact. Sol's Z1 also expands into proposed configuration fields and checks; this is an unscored scope-economy observation, not a retrospectively added failure criterion.

All 22 primary processes exited successfully with no error events and only `agent_message` completed items. Process success does not mean assertion success. One predeclared unchanged-condition repeat of Sol A1 again scored 3/5, omitting the same link and quotation. It is retained separately and excluded from primary totals; neither sample replaces the other. No other scored case was rerun to seek a pass.

## Native checks and evidence ceiling

Four isolated native attempts covered explicit `$rd-review` and `$rd-requirement` invocation, once per requested model. Current global and project templates were staged, with only the owning Skill copied to the project Skill root and eval files excluded. Shell and execution tools were enabled with `workspace-write` and approval policy `never`.

All four agents reported execution-policy rejection. Retained events contain no completed command execution or file change, and before/after manifests are identical. Both PRD attempts left the original threshold in place; the parent-run checker failed and the exact expected document comparison was false. Neither review produced substantive finding dispositions. **All four native attempts are blocked, not passed.** Unchanged files alone do not demonstrate review-only compliance.

A bounded inspection of the isolated test-home logs found no matching rejection diagnostic. Thus policy rejection is the agents' report, not an independently established root cause. Permissions were not relaxed and the four attempts were not blindly repeated. Native Skill loading, execution, and enforcement remain unverified until a functioning authorized tool path can be demonstrated.

## Reproduction and integrity

The canonical JSON contains frozen inputs and source hashes, prompt recipes and hashes, full final responses and hashes, frozen assertions, grades, exact-text/length checks, run order, usage, elapsed times, the separate diagnostic, and sanitized native staging/results. Historical [Astra evidence](evidence/astra-guidance-eval-2026-09-20.json) is unchanged.

Reconstruct a primary prompt with `"\n\n".join(record["inputs"][key] for key in case["prompt_parts"])` and verify its UTF-8 SHA-256 against `case["prompt_sha256"]`. Response hashes cover the retained response string. Native response hashes cover public path-redacted text; original hashes identify the unchanged local originals. Raw credentials, private provider metadata, and personal absolute paths are excluded.

Runs used Windows, `codex-cli 0.155.1`, one fresh ephemeral process and isolated home/workspace per sample, explicit high/high controls, existing authorized authentication, and a 240-second bound. Supplied-text runs disabled discovered Skills, project-document loading, shell, web search, apps, plugins, hooks, memories, and multi-agent features. Both context probes returned `none`; this is model self-report plus configuration evidence, not strong isolation proof. The supplied preamble also disallows tools, so text-only runs cannot measure live tool-use efficiency. The CLI observation does not update the repository's pinned release schema or broader tested baseline.

The task-local drivers are not a new supported framework. The public record is sufficient to reconstruct evaluation inputs without private paths or ignored files. An authorized rerun still needs working CLI/provider authentication and equivalent controls; host and backend differences may affect results.

## Completion and re-entry

The local implementation consists of the regression, bilingual report and compatibility pointers, changelog entry, and durable evidence. Repository validation checks shape and mirror contracts separately from model behavior. Passing static gates cannot erase the retained model failures or native blockers.

Validation passed: `scripts/validate.ps1`, all 20 negative cases in `scripts/test-validator.ps1`, and `git diff --check`. The scoped integrity audit verified frozen prompt/response/source hashes, grading excerpts, native staging manifests, per-language mirror byte equality, original-case preservation, local links, UTF-8/LF/no-BOM, and sensitive-pattern checks. The actual baseline had 43 cases per canonical language tree, including the v1.7.6 requirements addition; the new total is 44. Historical dated counts remain unchanged. The release-only network gate was not run because this task does not publish a release.

Reopen instruction edits when a bounded candidate can be causally tested against the observed failure and both models at high/high. Reopen native validation after diagnosing the authorized tool entry point; broader implicit routing, all-nine-Skill coverage, live retrieval, Claude/Cursor runtime, deployment, and business acceptance require their own evidence. No stability, speed, cost, universal compatibility, commit, push, or release claim follows from this experiment.
