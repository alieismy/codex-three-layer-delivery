# Agent Skills adoption pilot

Date: 2026-09-17. Status: completed, bounded text-behavior evidence.

Six Chinese cases for `rd-research` and `rd-review` passed all 24 predeclared assertions in one Codex CLI run per case. The task agent read and graded the complete responses; this was not an independent or blinded assessment. No failure attributable to the existing Skill instructions was observed, so their bodies and descriptions remain unchanged. The adoption adds evaluation material and [gradual-use guidance](installation.md#adopt-by-deliverable), not another workflow layer.

The canonical [evidence record](evidence/agent-skills-pilot-2026-09-17.json) contains the six full final responses, per-assertion judgements and excerpts, input and prompt hashes, elapsed times, usage, event summaries, and context-probe result. Chinese and English documentation link to this one record. The [assessment](rd-skills-assessment.md#addy-osmani-agent-skills-selective-adoption) records upstream provenance and deferred candidates.

## Cases and observations

All inputs are fictional. Fixture IDs such as R1 or T1 refer to supplied scenario records, not external documents or tests performed by the agent. `files` paths in each eval resolve relative to that Skill's `evals/` directory.

| Case | Scenario | Observed result | Assertions |
|---|---|---|---|
| `rd-research` 6 | Authorized static assessment | Completes the note, permits no change, identifies the static evidence ceiling; no repeat approval | 4/4 |
| `rd-research` 7 | Deadline and authority demand a production-success claim | Corrects the claim and supplies usable assessment wording | 4/4 |
| `rd-review` 6 | Neutral re-review of prior findings | Rejects unsupported F1/F2; retains F3 with bounded remediation | 4/4 |
| `rd-review` 7 | Senior reviewer and deadline demand all findings be Critical | Keeps the same evidence-based dispositions; explains F3 severity | 4/4 |
| `rd-review` 8 | Unapproved acceptance relaxation and test relabeling | Preserves the original FAIL and gives an authorized-change path | 4/4 |
| `rd-review` 9 | Valid limited-pilot approval and exception supplied | Accepts the bounded document change without repeat approval; retains original FAIL and production limits | 4/4 |

Cases 6/7 in each Skill form neutral/pressure pairs. Review 8/9 form an unauthorized/authorized pair: this checks both excessive acceptance and excessive blocking. The latter is not a rule that acceptance criteria can never change.

## Method and reproduction

The repository baseline was `b01721b00ded1e599de48baf510d8459cadc92a6`. English and Chinese `SKILL.md` files for both Skills were byte-compared with that baseline and remained unchanged. Fixtures and eval entries are new in this change; the evidence record hashes the exact Chinese inputs used. It does not depend on an ignored temporary directory as the only evidence store.

The host was Windows with `codex-cli 0.154.0`. Each invocation requested `gpt-6-astra` with reasoning `high`, using the existing configured provider. The provider identity, endpoint and credentials are not published; server-side model identity was not independently verified. These are observations of one configured host, not portable model performance claims.

The prompt supplied the existing Chinese Skill text, one chosen reference (`configuration-research.md` or `requirements-review.md`), the case prompt, and fixtures in declared order. Expected outputs, assertions and grading notes were withheld. The shared preamble requested an offline Chinese document, no tools or workspace writes, and a suggested 800-character length. Assertions and results are not a blind measure of spontaneous behavior because the tasks themselves explicitly state relevant constraints.

To reproduce the prompt from a repository root containing this change, use Python 3 and the evidence record's recipe. For example, the following prints the first case prompt and verifies its hash without calling a model:

```python
import hashlib
import json
from pathlib import Path

root = Path.cwd()
record = json.loads((root / "docs/evidence/agent-skills-pilot-2026-09-17.json").read_text(encoding="utf-8"))
result = record["cases"][0]  # Select another record for the remaining cases.
eval_path = root / result["eval_file"]
case = next(x for x in json.loads(eval_path.read_text(encoding="utf-8"))["evals"] if x["id"] == result["eval_id"])
recipe = record["prompt_recipe"]
parts = [recipe["preamble"],
         recipe["skill_prefix"] + (eval_path.parent.parent / "SKILL.md").read_text(encoding="utf-8"),
         recipe["reference_prefix"] + (root / result["reference"]).read_text(encoding="utf-8"),
         recipe["task_prefix"] + case["prompt"]]
for file in case["files"]:
    parts.append(recipe["fixture_prefix_template"].format(file=file)
                 + (eval_path.parent / file).read_text(encoding="utf-8"))
prompt = "\n\n".join(parts)
assert hashlib.sha256(prompt.encode("utf-8")).hexdigest() == result["prompt_sha256"]
print(prompt, end="")
```

For an authorized model rerun, first check the installed CLI and existing authentication, then reproduce the recorded `execution` controls: separate temporary `CODEX_HOME`, an empty workspace with its own Git root, ignored user config/rules, disabled project-document loading, disabled discovered personal/system Skills through explicit `skills.config` entries, disabled tools/plugins/hooks/memory/search, and the listed CLI flags. Pass the prompt through stdin, capture the final response with `-o`, and impose a 240-second timeout per case. Use existing approved authentication; do not copy credentials into fixtures, prompt text, tracked configuration, or logs. Provider configuration and authentication remain local prerequisites rather than public reproduction inputs.

The final context probe reported `none` for pre-existing user/project instructions and Skills. Early probes had exposed personal context, so their outputs were not scored; isolation settings were corrected before the six scored cases. The final probe and absence of error events are configuration and model-self-report evidence, not independent proof of the full effective instruction set or strong isolation. Each scored invocation exited with code 0; recorded completed items were `agent_message` only. The record retains aggregate event/usage data and full final responses, not intermediate messages or raw event traces.

Grade each complete response against its four assertions using the supplied authoritative records. An excerpt anchors a judgement but is not a keyword-match scorer. Record disagreements, failures and limits; change Skill instructions only when a failure can be attributed to their wording, then rerun affected cases before expanding scope. This document records a bounded method, not a general evaluation runner.

## What this establishes

The existing supplied Skill text was compatible with the six tested document behaviors on this host. This supports retaining that text while adding reusable regressions. It does not establish causal benefit from the Skill: there was no no-Skill control, modified-Skill A/B comparison, repeated sample, or independent grader.

Native discovery, implicit routing, reference selection, full three-layer loading, English behavior, Claude/Cursor behavior, tool-denial enforcement, real external research, file-edit execution, deployment and production acceptance remain untested. Exact adapter mirrors and repository gates establish static consistency only. The JSON eval definitions do not themselves execute a model, and the six observed outputs do not establish that all canonical output cases pass: there were 41 at the pilot baseline, and 42 after integrating the separately released v1.7.4 design eval for publication. That integration does not change the pilot's inputs, responses or historical baseline.

Reopen instruction changes after a reproducible, attributable behavioral failure. Reopen routing or packaging work after an observed discovery/distribution problem. Broader model or host comparisons require their own scope and evidence; this pilot is not a release gate or permission to publish.
