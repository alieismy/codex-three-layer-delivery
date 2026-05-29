---
name: rd-code-review
description: >-
  Use when reviewing code changes, pull requests, current diff, implementation
  quality, correctness, tests, security, or maintainability. Performs dual-stage
  review: compliance gate check then quality deep review. Do not use for writing
  new implementation code.
---

# $rd-code-review

Perform **dual-stage structured review** of code implementations, producing graded review findings.

## Deliverables

- Structured review report (graded issue list)
- Improvement recommendations (each with specific suggested fix)

## Dual-Stage Review Process

### Stage 1: Compliance Check (Gate Review)

Quick check to verify basic thresholds are met. Fail any item and the review is rejected immediately:

| Check Item | Standard |
|------------|----------|
| Design alignment | Does the implementation conform to the detailed design document? |
| Interface contract | Do interface signatures, inputs/outputs/error codes match? |
| Test existence | Do new features/fixes include accompanying tests? |
| Security baseline | No hardcoded secrets, no skipped input validation, no SQL concatenation |
| Build passing | Is CI green? |

**If any item fails, reject immediately with explanation. Do not proceed to Stage 2.**

### Stage 2: Code Quality Deep Review

After passing Stage 1, perform in-depth examination across the following dimensions:

#### 2.1 Correctness
- Is the logic correct? Are boundary conditions handled?
- Concurrency safety (race conditions, deadlock risks)
- Is error handling complete (recoverable / unrecoverable / degradation paths)?

#### 2.2 Maintainability & Code Smells

Naming and organization:
- Are names clear and self-explanatory?
- Is code organization sound (single responsibility, separation of concerns)?
- Does complex logic have WHY comments?

Code smell identification checklist:

| Smell | Detection Criteria | Recommendation |
|-------|-------------------|----------------|
| Duplicated code | Same logic appears in 3+ places | Extract method/component |
| Long function | > 50 lines | Split function |
| Large class/file | > 500 lines | Decompose module |
| Long parameter list | > 5 parameters | Introduce parameter object |
| Divergent change | One change requires modifying multiple unrelated areas | Reorganize responsibilities |
| Data clumps | Same group of parameters appears repeatedly | Extract data class |
| Excessive nesting | > 3 levels of nesting | Early return / extract method |
| Magic numbers | Unnamed literals | Extract constants |

#### 2.3 Performance
- Are there obvious performance issues (N+1 queries, unnecessary full table scans, memory leak risks)?
- Is algorithmic complexity reasonable?

#### 2.4 Security
- Is input validation sufficient?
- Is authentication/authorization logic correct?
- Does sensitive data handling meet requirements?

#### 2.5 Test Quality
- Do tests cover happy / error / boundary paths?
- Do tests have assertions (not just print statements)?
- Are tests independent and repeatable?

## Issue Grading

Label each review finding with a severity level:

| Severity | Meaning | Requirement |
|----------|---------|-------------|
| **Critical** | Blocks merge, may cause incidents | Must fix |
| **Major** | Significant quality issue | Should fix |
| **Minor** | Improvement suggestion | Recommended fix |
| **Nit** | Style / preference | Optional |

## Spec Injection Check

Pre-execution checks:
- Project coding conventions and code style configuration
- Existing code review checklists
- Branch merge strategy and PR conventions

## MCP Tool Usage

- **Augment Context Engine**: Cross-file and cross-repository code tracing
- **Context7**: Verify API usage against latest documentation

## Quality Gates

Pre-delivery checklist:

- [ ] All 5 Stage 1 checks executed
- [ ] Each issue has a severity level and specific suggested fix
- [ ] Critical/Major issues include code line number references
- [ ] "Must fix" vs. "Should fix" clearly distinguished
- [ ] Review covers all changed files

## Gotchas Collection

Code review is the best opportunity to discover gotchas. After review completion:

- If **recurring error patterns** are found (e.g., repeatedly missing pagination parameters, ignoring concurrency handling), record them as a Gotcha
- Record format: Problem / Symptom / Fix / Prevention (see the Gotchas Log section in the project AGENTS.md)
- Same type of issue appears 3+ times → recommend promoting to a coding standard or automated check

## Out of Scope

- Do not just say "LGTM" or "looks good" — provide a structured review
- Do not rewrite code in place of review findings — provide fix recommendations for the author to implement
- Do not initiate architecture-level discussions during code review (escalate to `$rd-doc-review`)
