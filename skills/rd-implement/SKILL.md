---
name: rd-implement
description: >-
  Use when implementing code from requirements or detailed design, fixing bugs,
  refactoring code, or writing tests alongside implementation. Follows TDD
  RED-GREEN-REFACTOR cycle with verification before completion. Do not use for
  pure code review or deployment-only tasks.
---

# $rd-implement

Produce **runnable, testable, deployable code** based on the design.

## Deliverables

- Implementation code aligned with the design
- Necessary unit tests (committed alongside the code)
- Change records (changelog entries)

## Core Principles

1. **Think before you code**: State assumptions and implementation plan before writing code. When multiple approaches exist, explain the rationale first.
2. **Simplicity first**: Choose the simplest implementation that satisfies the requirement. Do not add complexity for hypothetical future needs.
3. **Minimal changes**: Only change what must be changed. Do not opportunistically refactor unrelated code.
4. **Goal-driven**: Convert requirements into verifiable goals ("write a failing test → make the test pass").

## Execution Steps

### 1. Context Loading

- Read relevant design documents (`$rd-detailed-design` output)
- Read target files, callers, interface definitions, related tests
- Check project specs (`AGENTS.md` / `AGENTS.override.md`)
- Confirm tech stack versions and dependency constraints

### 2. Implementation Plan

When the change affects multiple files or crosses module boundaries, output a brief implementation plan first:
- List of files to modify with **full file paths** (resists context decay — allows relocation even if the model loses context)
- Modification order and dependencies
- Expected result and verification command for each step
- Risk annotations

### 3. Coding

Follow project-level code quality thresholds:

| Constraint | Threshold |
|------------|-----------|
| Single function/method | ≤ 50 lines |
| Single file | ≤ 500 lines |
| Nesting depth | ≤ 3 levels |
| Function parameters | ≤ 5 |

Coding discipline:
- Prefer reusing existing patterns and infrastructure
- Before introducing new dependencies, confirm version, license, and known vulnerabilities
- No hardcoded secrets / tokens / API keys
- Comments explain WHY, not WHAT
- Do not add abstraction layers preemptively because "it might need to scale later"

### 4. Synchronized Testing (TDD RED-GREEN-REFACTOR)

Use fine-grained TDD cycles — **complete one full cycle per interface/feature before moving to the next**, rather than writing all tests first then implementing:

1. **RED**: Write a failing test first (define expected behavior)
2. **GREEN**: Write the minimum code to make the test pass
3. **REFACTOR**: Clean up redundancy, improve structure, ensure tests still pass
4. Move to the next interface/feature, repeat the cycle

Granularity guidelines:
- New features: one TDD cycle per interface
- Bug fixes: write a reproduction test first (RED), then fix (GREEN)
- Refactoring: ensure all tests pass before and after
- Test coverage at minimum: happy path + critical boundary conditions

### 5. Verification Before Completion

**Do not claim "done" — self-verify first:**

- Run the existing test suite, confirm no regressions
- Check linter / formatter for no new errors
- Confirm the scope of changes matches the plan, no scope creep
- Cross-check against design documents for interface and data model alignment
- In the final report, distinguish: Completed / Verified / Unverified / Technical Debt

## Spec Injection Check

Pre-execution checks:
- Project coding conventions (naming, formatting, error handling)
- Git commit conventions (commit message format)
- Existing architectural patterns and design decisions
- CI/CD pipeline requirements

## MCP Tool Usage

- **Context7**: Query library/framework API usage — prefer documentation over guessing when unsure
- **Sequential Thinking**: Complex algorithm or concurrency logic reasoning
- **Augment Context Engine**: Cross-repository code search and pattern reference

## Quality Gates

Pre-delivery checklist:

- [ ] Code aligns with design document interfaces and data models
- [ ] Core features have unit test coverage
- [ ] No hardcoded secrets
- [ ] Existing tests pass, no regressions
- [ ] Linter / formatter reports no new errors
- [ ] Changes are traceable to requirements or design
- [ ] Complex logic has comments explaining WHY

## Over-Engineering Indicators

- Only 1 implementation currently exists → Do not introduce interfaces / abstract factories
- No change requirement exists currently → Do not use Strategy / Template Method patterns
- Eliminating duplication would introduce greater complexity → Tolerate moderate duplication

## Failure Fallback Strategy

- **Two-failure rule**: Same problem fails to fix twice in a row → recommend starting a new session + `git reset --hard`, begin from a clean context
- Rationale: Consecutive failures usually mean the context is contaminated by the wrong direction; continuing to fix in the same session tends to drift further off course
- Before falling back, write the current analysis and failure reasons to Memories or AGENTS.md to avoid repeating the same mistakes in the new session

## Out of Scope

- Do not skip reading code and jump directly to writing code
- Do not "incidentally" improve adjacent code, comments, or formatting
- Do not delete existing unrelated code (even if it appears to be dead code)
- Do not introduce abstractions, patterns, or dependencies not requested
