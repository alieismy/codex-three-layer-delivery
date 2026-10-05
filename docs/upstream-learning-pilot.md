# Upstream Learning Follow-up and Bounded Pilot

Date: 2026-10-05. Status: bounded sampling and semantic review complete; repository checks recorded below. No release or production-acceptance claim.

## Scope and decision

The approved follow-up covers three small comparisons: native `rd-review` availability versus a disabled-target baseline; input-scoped evidence validity and actual handoff reading; and cross-artifact meaning plus caller knowledge obligations. It preserves the nine-Skill taxonomy, permission boundaries, public model defaults, and platform invocation differences.

The repository baseline is Commit `075338c4273a0b5e4575268e77c516e135e85f3e`. The earlier [native routing records](compatibility.md#codex) remain valid at their dated scope. They are reused as loading evidence, not relabeled as output-quality or causal-benefit evidence. This follow-up uses explicitly synthetic fixtures; no external business document package, real application interface, production system, or upstream runtime was exercised.

## Inspected upstream snapshots

These pins identify the source actually inspected. A package version does not identify a matching release commit. License observations concern these snapshots; see [ATTRIBUTION.md](../ATTRIBUTION.md) for historical observations and copying boundaries.

| Source | Inspected snapshot and version distinction | Mechanism and bounded disposition |
|---|---|---|
| Matt Pocock Skills | [main / v1.3.1, 24fe0ef](https://github.com/mattpocock/skills/tree/24fe0ef7737efae15c87225755e9f6f5965e4888); MIT | [Caller knowledge obligations](https://github.com/mattpocock/skills/blob/24fe0ef7737efae15c87225755e9f6f5965e4888/skills/engineering/codebase-design/SKILL.md) and [domain meaning](https://github.com/mattpocock/skills/blob/24fe0ef7737efae15c87225755e9f6f5965e4888/skills/engineering/domain-modeling/SKILL.md) inform the two design cases. No module-depth score or coding workflow is imported. |
| Addy Osmani Agent Skills | [main, 1401c8b](https://github.com/addyosmani/agent-skills/tree/1401c8b8030e023baeebb31781a6653fe8e93026); manifest 0.6.12 differs from release commit a06bc63; MIT | [Native and comparative evaluation](https://github.com/addyosmani/agent-skills/blob/1401c8b8030e023baeebb31781a6653fe8e93026/evals/README.md) informs separate loading, semantic quality, and cost observations. The upstream runner is not imported. |
| gstack | [main, 857466f](https://github.com/garrytan/gstack/tree/857466ff8b93c0575bc9e46cf2838d1962077d8f); VERSION 1.91.25.0; no tags/releases returned by the API at inspection; MIT | [Current-workflow and workaround observations](https://github.com/garrytan/gstack/blob/857466ff8b93c0575bc9e46cf2838d1962077d8f/office-hours/sections/phase-2a-startup-diagnostic.md) remain a problem-selection method for future real-user trials. This synthetic pilot does not measure demand or workflow savings. |
| GSD Core | [next, a1f3db9](https://github.com/open-gsd/gsd-core/tree/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7); package 1.16.0 differs from tag commit 87e87d; MIT | [Evidence states](https://github.com/open-gsd/gsd-core/blob/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7/src/gate-evidence.cts) and [context drift](https://github.com/open-gsd/gsd-core/blob/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7/src/gate-context-drift.cts) inform scoped reuse and unreadability cases. No runtime gate or timestamp-based semantic verdict is imported. |
| Athena in Rlues | [main, ac99fc5](https://github.com/WenJunDuan/Rlues/tree/ac99fc55b44aab8622a0f7b784bccea1f431dffb/vibeCoding/athena); VERSION 10.1.0 with post-release changes; no applicable license found in inspected scope | [Input-bound review](https://github.com/WenJunDuan/Rlues/blob/ac99fc55b44aab8622a0f7b784bccea1f431dffb/vibeCoding/athena/gate/rules/h3-review.cjs) informs evidence identity. Rule-retirement reasoning remains conditional on a future justified rule change. No hooks, ledger, whole-tree invalidation scheme, or protected expression is copied. |
| oh-my-codex | [main, 1dcf513](https://github.com/Yeachan-Heo/oh-my-codex/tree/1dcf51359f3caeeebfed0bcbeea867ff0838d533); package/latest release 0.21.7; MIT LICENSE now verified | [Example/counterexample elicitation](https://github.com/Yeachan-Heo/oh-my-codex/blob/1dcf51359f3caeeebfed0bcbeea867ff0838d533/skills/deep-interview/SKILL.md) and [verification modes](https://github.com/Yeachan-Heo/oh-my-codex/blob/1dcf51359f3caeeebfed0bcbeea867ff0838d533/skills/autoresearch/SKILL.md) are useful comparisons to existing methods. No numeric ambiguity threshold, runtime, or new Skill is adopted. |
| Trellis | [main, f089cb3](https://github.com/mindfold-ai/Trellis/tree/f089cb3286071199e84118dee86b6d76aab032f1); CLI/core 0.6.17 differs from same-name tag; package AGPL-3.0-only | [Role-scoped context lists](https://github.com/mindfold-ai/Trellis/blob/f089cb3286071199e84118dee86b6d76aab032f1/packages/cli/src/templates/common/bundled-skills/trellis-meta/references/local-architecture/context-injection.md) and [partial/index-only visibility](https://github.com/mindfold-ai/Trellis/blob/f089cb3286071199e84118dee86b6d76aab032f1/packages/cli/src/templates/shared-hooks/inject-subagent-context.py) inform the handoff case. No injector or directory model is copied. |

The strongest reason to retain current instructions is their existing coverage of authority, evidence levels, invalidation, interface contracts, and bounded adoption. The candidate methods therefore test more concrete representations of those principles. They do not presume a new capability gap merely because an upstream project has a named mechanism.

## Frozen comparison design

The [single evidence record](evidence/upstream-learning-pilot-2026-10-05.json) retains full responder inputs, source snapshots and hashes, separate grader assertions, first responses, semantic grading, aggregate CLI events, elapsed time, token fields, and the dated launcher source. English and Chinese reports point to the same evidence record.

Inputs were frozen before sampling. Each of seven cases has two arms, with alternating order across cases and one first attempt per cell. The requested settings are Codex CLI 0.160.0, `gpt-6-astra`, reasoning `max`, verbosity `medium`, and a 240-second per-cell limit. Existing private provider/authentication settings remain local; backend identity is not independently attested. No credential, private endpoint, raw session stream, or personal absolute path belongs in the public evidence.

Common per-process controls are ephemeral execution, ignored rule files, read-only sandbox, approval `never`, `project_doc_max_bytes=0`, hooks/memories/apps/plugins off, and web search disabled. All nine RD Skills are disabled by name. The native with-target arm re-enables only the staged Chinese `rd-review/SKILL.md` by exact file path. Both native arms have the same staged payload; actual file reads are inspected for contamination. Other inherited host/system context and installed Skill metadata remain possible shared influences. These controls did not isolate inherited MCP initialization from the network; no responder MCP tool call was observed.

A successful native read probe returned a unique file marker through an actual completed command before sampling. Five non-model `skills/list` probes established that this CLI accepts an exact `SKILL.md` selector; a directory selector did not disable the staged entry. Disabled entries still appeared with `enabled=false`. These are bounded local selector observations, not a general platform contract.

| Cases | Material and arms | What the comparison can establish |
|---|---|---|
| N1 | File-based independent review of inherited findings; target disabled / enabled | Whether the enabled target is actually read and whether findings improve beyond a retained-context baseline |
| N2 | Inline criterion-change records including a valid bounded owner approval; enabled / disabled | Quality and authority boundaries when material is supplied directly in the message |
| N3 | Adjacent factual three-row table request with an explicit no-review boundary; disabled / enabled | Whether the available target causes an unnecessary review workflow in this selected near miss |
| A1, A2 | Current Chinese `rd-delivery` body and delivery-record reference, versus the same text plus optional method A | Affected-scope invalidation, justified reuse, unreadable evidence, and actual consumption state |
| B1, B2 | Current Chinese `rd-design` body, versus the same text plus optional method B | Meaning drift across artifacts and fair interface comparison based on caller obligations |

Document cells receive supplied text, with shell tools disabled; they are not native discovery tests. Candidate A links verification results to input revisions, coverage, reuse conditions, and read state. Candidate B traces a term's actor/event/precondition/effect/outcome/authority and compares caller obligations, responsibility, failure visibility, and a reversible discriminating trial. Complete method text is frozen in the evidence, not added to an always-loaded rule.

Rubrics judge substantive findings, false positives, retained behavior, missing contracts, and evidence/authority boundaries. Titles, exact keywords, and verbosity do not earn credit. A separate task agent grades anonymized outputs without arm labels or the candidate-method text; the maintainer checks material judgments against the fixtures. This is a separation of evaluation roles, not an independent external benchmark. Disagreements and partial/failing assertions remain visible.

## Results and adoption

All 14 first attempts completed with exit code 0. Each response passed its four frozen assertions: **56/56**, comprising 24 native and 32 supplied-text assertions. The separate grader and maintainer sustained the same ratings; no substantive disagreement or additional finding remained. During evidence assembly, newline-separated excerpt bundles were initially treated as contiguous quotes. They were preserved as separate, exact-match array elements after checking every span; no prompt, response, assertion, or grade changed.

| Case | Baseline / treatment assertions | Observed result |
|---|---|---|
| N1 | 4/4 / 4/4 | Both rejected the two unsupported inherited findings and retained the real omission. Only the enabled arm read the complete target body. |
| N2 | 4/4 / 4/4 | Both accepted the valid bounded approval without rewriting the historical failure or requesting approval again. Only the enabled arm read the complete target body. |
| N3 | 4/4 / 4/4 | Both returned the requested factual table; neither read the target or expanded into review. |
| A1 | 4/4 / 4/4 | Both invalidated the recovery-budget conclusion only where affected, retained historical evidence, and reused the unchanged terminology review. |
| A2 | 4/4 / 4/4 | Both kept unreadable/partial/index-only inputs distinct, preserved the link-check result at its scope, and left the schema gate unverified. |
| B1 | 4/4 / 4/4 | Both separated queue receipt from owner approval, retained the public field and valid stub observation, and kept missing contracts explicit. |
| B2 | 4/4 / 4/4 | Both compared actual caller obligations and responsibility, retained the working composition as a genuine option, and proposed a trial that could favor either design. |

For native cases, baseline means target disabled and treatment means target enabled. For document cases, baseline means current supplied text and treatment means that text plus the optional method. These are assertion-level results on selected cases, not a complete measure of answer quality. The baseline already reached the rubric ceiling in every selected case, so this batch cannot distinguish benefits outside those assertions.

| Group | Arm | Cells | Total elapsed seconds | CLI input tokens | Cached input tokens | CLI output tokens |
|---|---|---:|---:|---:|---:|---:|
| Native | Target disabled | 3 | 212.483 | 110,518 | 43,520 | 4,901 |
| Native | Target enabled | 3 | 193.962 | 190,839 | 116,864 | 4,536 |
| Supplied text | Current instructions | 4 | 484.094 | 97,729 | 13,312 | 11,822 |
| Supplied text | With optional methods | 4 | 564.260 | 98,683 | 0 | 14,243 |

The optional-method cells used 2,421 more output tokens and 80.166 more elapsed seconds in this batch without improving frozen assertion scores. This is a reason not to expand the instruction surface on this evidence, not a stable estimate of overhead. Cache differences, inherited startup activity, order, and backend latency prevent a general speed or monetary-cost inference. Token columns are the CLI's reported fields; reasoning-token detail is retained in the JSON and is not added to output tokens again.

The adopted result is four reusable regressions and auditable paired evidence. `rd-delivery` evals 7/8 and `rd-design` evals 5/6 are synchronized across the English and Chinese canonical roots and their Claude/Cursor mirrors. Each canonical tree now has **51 output-case definitions**, up from 47. This experiment executed seven selected cases twice; it did not execute all 51 definitions.

Existing Skill bodies, descriptions, references, the delivery-record template, routing, permissions, and public model defaults remain unchanged. Candidate method text remains in the experimental evidence; scoped evidence validity is demonstrated in this package's index. Equivalent baseline performance does not prove that the existing Skills are unnecessary; retained context and model capabilities can already cover these cases. Reopen instruction changes after a material reproducible failure or measurable recovery/caller burden on a real document package or interface. No new top-level Skill, hook, state engine, runtime dependency, or general validator is introduced.

Repository checks passed: `pwsh ./scripts/validate.ps1`, all 24 cases in `pwsh ./scripts/test-validator.ps1`, and `git diff --check`. The four affected canonical Skill packages also passed `quick_validate.py`. Existing eval objects were preserved, all six payload mirrors were checked, and full-response/input hashes, exact excerpt spans, LF/UTF-8, local links, and the changed-file privacy scan passed. The first public JSON export used CRLF and was rejected by the validator; conversion to LF was followed by a passing run. These static checks do not raise the behavioral evidence level. The release-only network gate was not run because no release was requested.

## Scoped evidence and resumption

This repository change uses its own report as an index into authoritative artifacts. It does not create a competing state store. The actual maintenance scope is distinct from the synthetic fixture contents.

| Evidence | Input identity and coverage | Reuse and next-check boundary |
|---|---|---|
| Upstream inspection | Seven fixed commits above; selected source mechanisms and license files read | Reopen a factual source claim if its pin or cited file changes; no upstream runtime or benefit result exists |
| Frozen experiment inputs | Baseline commit plus full prompt, Skill/reference, fixture, and rubric hashes | Later eval-file additions do not rewrite the sampled instructions; a changed instruction or rubric requires a separately identified comparison |
| Native observation | Exact staged target and completed tool events per cell | Availability, attempted reads, complete successful reads, and final quality are distinct; an index or model self-report is insufficient |
| Semantic grading | Complete recorded first response plus the corresponding frozen fixture/assertions | A changed response or criterion invalidates only its grading; retain the original observation as history |
| Repository gates | Final changed files, maintained mirrors, and existing positive/negative validators | Establish static shape, syntax, references and mirror contracts; do not establish model reliability, external approval or release |

Critical input consumption is recorded by purpose: the source snapshots underpin the mechanisms; full frozen fixture/instruction text underpins sampling; complete first responses underpin grading. Unreadable or partial material must remain explicitly unverified for its affected decision. No output in this package authorizes a business deployment or replaces an owner decision.

## Reproduction and remaining limits

Use the retained frozen inputs and launcher as the dated recipe in an ignored local directory, preserving the baseline, treatment order, per-process controls, current approved provider/authentication prerequisites, and timeout. Keep grader-only data outside responder workspaces. Never copy credentials into a reproduction package. Record changed CLI/model/environment settings as a new comparison rather than overwrite these first attempts. Raw local streams support audit of tool events but are intentionally not published.

The experiment does not isolate all inherited context, randomize repeated samples, measure cold-cache monetary cost, or attest backend model identity. N1-with logged an inherited MCP initialization timeout of about 30 seconds and still completed successfully; the PowerShell shell-snapshot warning is also retained separately from successful file-tool execution. Startup state and cache differences prevent interpreting a faster cell as a speed improvement. Chinese behavior here does not establish English, Claude, Cursor, desktop, long-horizon handoff, user-effort savings, or production acceptance. A real document package or interface trial remains the next evidence needed for those benefits. gstack-style workflow observation and a cold review of a consequential real decision remain optional future methods; this change does not impose them on every task.

## Real-artifact handoff follow-up (2026-10-05)

The user selected this repository change as the real document package for the next bounded check. Two fresh review tasks received the public artifacts and review scope without the earlier conversation. One reconstructed the report's conclusions and all 56 ratings from the complete retained inputs and responses; the other prepared the dated launcher through an offline process substitute, without the author's earlier task-local files. The [follow-up evidence](evidence/upstream-learning-real-artifact-2026-10-05.json) records input identities, actual reading scope, results, the correction, and reuse limits. These are task-agent reviews checked by the maintainer, not external certification or a randomized benefit comparison.

The report and JSON agreed on 14 recorded responses, 56 passing assertions, the four cost totals, and the 2,421-token / 80.166-second difference. The 10 frozen input texts still match their current canonical files. All 9 native payload files match the recorded baseline Git blobs; offline preparation recovered all 14 prompt hashes and all 6 native staged payloads. The preparation check also checked the exact allowed workspace files, the generated TOML settings and JSON results, and refusal to overwrite an existing cell. It did not start Codex or rerun the model experiment. Public event summaries remain the author's retained observations; this handoff review did not re-observe their original commands or inspect the private raw streams.

One **Minor** usability finding was reproduced: the original reproduction note did not specify the serialization needed to recover the manifest's exact byte hash. A normal LF export is logically equivalent but has a different file hash. The original serialization is UTF-8 without BOM, `ensure_ascii=False`, `indent=2`, a final newline, and CRLF line endings. This finding concerns representation and handoff effort; it does not invalidate the sampled inputs or scores. The original evidence JSON and launcher remain unchanged. The deterministic export below closes this documentation gap.

Run this preparation block in PowerShell from the root of the recorded baseline checkout, with the public evidence JSON retained at its documented path. It requires Python and Git. It verifies the baseline and native payload before creating a new run directory; an existing directory is refused. The exact `.tmp/local/<dated-run>/` depth is required by the dated launcher. This step restores files only and makes no model call.

```powershell
@'
import hashlib
import json
from pathlib import Path
import subprocess

root = Path.cwd()
record = json.loads((root / 'docs/evidence/upstream-learning-pilot-2026-10-05.json').read_text(encoding='utf-8'))
head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip()
if head != record['baseline_commit']:
    raise SystemExit('Use the recorded baseline checkout and retain the public evidence JSON there.')

manifest_text = json.dumps(record['frozen_inputs'], ensure_ascii=False, indent=2) + '\n'
manifest_bytes = manifest_text.replace('\n', '\r\n').encode('utf-8')
launcher_bytes = record['launcher']['source'].encode('utf-8')
for data, expected in [(manifest_bytes, record['frozen_manifest_sha256']),
                       (launcher_bytes, record['launcher']['sha256'])]:
    if hashlib.sha256(data).hexdigest() != expected:
        raise SystemExit('Restored bytes do not match the retained evidence hash.')
for relative, snapshot in record['run_controls']['native_skill_snapshot'].items():
    source = root / 'zh-CN/skills/rd-review' / relative
    if hashlib.sha256(source.read_bytes()).hexdigest() != snapshot['sha256']:
        raise SystemExit('Native Skill payload differs from the recorded baseline: ' + relative)

run = root / '.tmp/local/upstream-learning-replay-20261005'
run.mkdir(parents=True, exist_ok=False)
(run / 'frozen-inputs.json').write_bytes(manifest_bytes)
(run / 'run_pilot.py').write_bytes(launcher_bytes)
print('Prepared ' + run.relative_to(root).as_posix() + '; no model process started.')
'@ | python -
```

The export was executed locally: both restored hashes matched, the launcher resolved the intended repository, seven case definitions loaded without starting the main entry point, and a second export was refused with the existing bytes preserved. Restored CRLF files stay under ignored `.tmp/local/`; repository source and evidence files remain LF. A later model run still requires the approved provider/authentication and dated environment controls, and its outcome must be checked per cell. A completed launcher is not proof that every cell succeeded.

The scoped reuse decision is to retain the original sampling, grading, and upstream observations at their original evidence levels. This correction changes the reproduction instructions, so the export and applicable document checks are refreshed; it does not justify repeating model calls or altering Skills. The real repository handoff and preparation path has now been exercised. Long-term user effort, real business interfaces, cross-client behavior, and causal improvement remain unmeasured.
