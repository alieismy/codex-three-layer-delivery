# Optional Jev semantic-check pilot

Date: 2026-09-21. Status: live API pilot completed; advisory use only.

## Decision

Use Jev selectively for narrow semantic classification and screening after code has handled exact checks. Codex retains responsibility for evidence selection, complex reasoning, disagreement review, and final conclusions. The trial found a high-confidence false positive, so neither a passing label nor a confidence threshold can grant document approval, erase a failure, or authorize an action.

The user-level `typesafe-ai` Skill provides integration guidance; it does not install a model, supply API credentials, or intercept native Skill routing. The optional runner below implements one bounded experiment. It does not add a public Skill, a default external dependency, a new router, a mandatory pipeline, or a release gate.

## What actually used Jev

| Work | Executor | Established result |
|---|---|---|
| One synthetic evidence/claim preflight | Jev through the HTTP API | Authentication and typed response succeeded |
| 78 narrow semantic checks over 22 historical final answers | Jev, one request per answer with independent questions batched | All 22 requests completed; complete answers, probabilities, usage and timing retained |
| Hashes, exact PRD preservation, word/character limits, policy link and verbatim phrase presence | Python | Deterministic regressions retained; no model used for these checks |
| Scope, question design, all five flags, ten additional response samples, final disposition | Task Codex agent | Four flagged omissions confirmed; one flag rejected on direct text evidence |
| Native Skill routing, live citation workflow, translation checking | Not executed | Remain candidates requiring separate evidence |

The [primary API record](evidence/jev-pilot-2026-09-21.json) is separate from the [Codex review record](evidence/jev-pilot-review-2026-09-21.json). Original source responses and original grades remain in the unchanged [September 20 record](evidence/dual-model-eval-2026-09-20.json). Model and environment observations are indexed in [compatibility](compatibility.md#optional-jev-pilot).

## Method and results

The source record contains eleven cases with two final answers each. The runner defines 39 case-level checks, yielding 78 answer-level judgments: 56 on English responses and 22 on Chinese responses. All questions are written in English. These are new, narrow conditions, not the 96 original compound assertions. In particular, explicit synthetic provenance is stricter than merely avoiding a real-world deployment claim. No original score is overwritten or silently recalculated.

For each request, `state` contains the complete retained final answer and relevant synthetic fixtures/tasks. Global rules, project rules, full Skill bodies, original grades, model labels and expected labels are excluded. The actual request hash, selected source keys, response hash, question catalog and runner hash allow reconstruction. The model receives the full answer, not a keyword excerpt. Question instructions explicitly distinguish source material from the answer being evaluated.

Jev returned **73 `satisfied`, 5 `violated`, and 0 `uncertain`**. These are model labels, not 73 verified passes. All five flags concerned explicit synthetic provenance:

| Sample | Retained answer | Jev confidence | Codex disposition |
|---|---|---:|---|
| S04 | English static assessment | 0.95 | **False positive.** Section 2 says: “The assessment is limited to the supplied synthetic records:” |
| S09 | English completed evidence note | 0.99 | Confirmed omission in the complete answer |
| S15 | English brief, first retained answer | 0.98 | Confirmed omission in the complete answer |
| S16 | English brief, second retained answer | 1.00 | Confirmed omission in the complete answer |
| S21 | Chinese brief, first retained answer | 0.92 | Confirmed omission in the complete answer |

The task Codex agent read each flagged response completely, then checked ten selected satisfied-response samples covering all eight question families and both languages. Their 34 selected conditions agreed with the response text. The remaining 39 `satisfied` conditions were not individually adjudicated. This was not a human review, independent audit, or blinded reference-label exercise: the task agent had access to the historical record and saw Jev's labels. No labels were frozen before execution, no threshold was tuned, and no held-out reliability estimate follows. The false positive was not rerun or replaced to obtain a pass.

Deterministic checks separately retained the missing English policy link and verbatim clause, missing Chinese policy link, the 239-word English brief exceeding 220 words, and three added blank lines in the Chinese PRD that violate exact preservation. The Chinese PRD can satisfy the two semantic questions while failing exact preservation. Passing these narrow semantic checks never means that the entire response is acceptable.

The 22 primary requests used **48,068 input tokens and 3,521 output tokens**. Observed sequential request times were **0.875–1.152 seconds**, with a **0.943-second median** and **21.264 seconds summed request time**. This excludes preparation, reading, interpretation, testing and documentation; it does not establish net time savings. The separate preflight brings total observed calls to 23 and input usage to 48,454 tokens. At the [published price](https://docs.typesafe.ai/models) checked on the report date, estimated primary inference cost is **$0.002019**, or **$0.002035 including preflight**; actual billing was not checked.

## Reproduce the bounded pilot

The [runner](../scripts/run-jev-pilot.py) uses Python 3.9+ standard-library HTTP support. No SDK or new dependency installation is required. Run commands from the repository root.

Inspect request counts, source hashes and deterministic results without network access or credentials:

```powershell
python scripts/run-jev-pilot.py preview
python scripts/test-jev-pilot.py
```

After authorizing transmission of these public synthetic inputs and the small API charge, run with `TYPESAFE_API_KEY` available to the process. A newly added Windows user environment variable may not exist in an already-running terminal. This example imports it for the command and restores the previous process value without printing it:

```powershell
New-Item -ItemType Directory -Force .tmp/local/jev-pilot | Out-Null
$previousKey = $env:TYPESAFE_API_KEY
try {
    if (-not $env:TYPESAFE_API_KEY) {
        $env:TYPESAFE_API_KEY = [Environment]::GetEnvironmentVariable('TYPESAFE_API_KEY', 'User')
    }
    python scripts/run-jev-pilot.py run --output .tmp/local/jev-pilot/new-run.json
    if ($LASTEXITCODE -ne 0) { throw 'Jev pilot did not complete; inspect the retained record.' }
}
finally {
    $env:TYPESAFE_API_KEY = $previousKey
}
```

The destination must not exist; use a new filename for another authorized run. The runner validates returned model, question keys, types, probability ranges and usage. It does not follow redirects with the credential. Only a 429/529 response permits one bounded retry, respecting a numeric `Retry-After` up to 30 seconds; other errors stop the run. Each completed call is saved before continuing. A failed run remains partial and must not be reported as a pass; there is no automatic resume or replacement of old samples.

This runner intentionally targets the frozen September 20 public record rather than accepting arbitrary documents. Adapting it to new or private material requires selecting an appropriate input boundary, reviewing the data sent, and defining checks for that task. No evidence is obtained merely by changing a filename or invoking the Skill.

## Suggested task wording

This is an optional task prompt, not an always-loaded rule:

> Use the typesafe-ai Skill. Keep complex reasoning, evidence interpretation and final conclusions with Codex. Prefer Jev for suitable narrow semantic classification, screening and simple judgments over authorized material; use code for exact rules, arithmetic and text comparison. Review uncertain results and flagged issues, and sample unflagged results. Model confidence cannot grant approval. Report which steps actually called Jev, the model, input scope, request count, cost evidence, failures and remaining verification limits. Use existing routing unless this task explicitly includes a routing experiment.

For this repository, evaluation support is the first demonstrated entry point. Citation-support checks are a next candidate; bilingual semantic comparison and Skill routing remain deferred. A small catalog and an existing router do not justify an extra model call on every turn.

## Validation

On 2026-09-21, repository validation passed, all 20 then-existing validator negative cases passed, and the five then-existing offline pilot tests passed. The task integrity audit reconstructed all 22 requests, validated all 78 typed answers, matched every retained review excerpt to the unchanged historical responses, checked local links and UTF-8/LF formatting, and checked changed/new artifacts for the exact credential value and bounded sensitive patterns. `git diff --check` passed. These checks validate artifacts and error handling, not model reliability. The release-only network gate was not run; no commit, push or publication was performed.

The 2026-10-02 repair adds explicit object-shape checks for service responses and seven offline tests, including malformed-response evidence persistence. The original 22 API calls were not repeated or relabeled. The [frozen historical runner](evidence/jev-pilot-runner-2026-09-21.py) matches the `runner_sha256` in the original evidence. To reconstruct those requests, place the archived bytes at `scripts/run-jev-pilot.py` in an isolated checkout and use `preview`; the archive is not an executable entry point in its evidence directory. The current runner contains the repair.

## Evidence limits and sources

- [Introduction](https://docs.typesafe.ai/introduction), [Choice](https://docs.typesafe.ai/primitives/choice) and [HTTP API](https://docs.typesafe.ai/api) establish the typed question contract. Typed output is not proof of correctness.
- [Confidence](https://docs.typesafe.ai/confidence) describes distribution-based confidence. The S04 error directly demonstrates why it cannot be treated as an approval probability.
- [Known Jev limitations](https://docs.typesafe.ai/model-jaggedness/jev-1.13) include irrelevant-context sensitivity, literal reading and adversarial content. This pilot does not isolate the cause of S04 or test adversarial robustness.
- [Models](https://docs.typesafe.ai/models) documents weaker non-English performance and current input/pricing limits. This small mixed-language sample cannot establish Chinese parity or future-model compatibility.
- [Privacy policy](https://typesafe.ai/legal/privacy-policy) and [Legal](https://docs.typesafe.ai/legal) distinguish no-training commitments from enterprise zero retention. Only public synthetic task material and historical final responses were sent; personal configuration, credentials and private session history were excluded.

The pilot supports an optional advisory experiment, not a default model preference, calibrated classifier, replacement reviewer, native routing integration, production acceptance, or release decision. Continue only where representative task-specific evidence shows a benefit after accounting for review cost.
