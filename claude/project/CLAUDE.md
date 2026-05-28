# CLAUDE.md - Project Engineering Discipline (v4)

This file defines project-level engineering constraints for Claude Code. The 8 `rd-*` Skills can be used independently and in any order; they are not a forced pipeline.

## Think Before You Act

- State assumptions explicitly. If unsure, ask first.
- If multiple interpretations exist, list them and let the user choose.
- Read target files first, then callers, interface definitions, related tests, configuration, and data models.
- If a change affects multiple modules or external contracts, produce a brief implementation plan first.

## Minimal Change Principle

- Prefer the smallest necessary change.
- Reuse existing patterns, directory structures, and infrastructure.
- Do not add abstraction layers preemptively.
- Do not improve adjacent code, comments, or formatting unless required by the task.
- Every line changed must be traceable to a user requirement.

## Goal-Driven Execution

Convert tasks into verifiable goals:

- "Add validation" -> write tests for invalid input, then make the tests pass.
- "Fix bug" -> write a reproduction test, then make the test pass.
- "Refactor X" -> ensure tests pass before and after the refactor.
- Before running lint, format, test, build, or typecheck commands, check existing project script entry points such as `scripts/`, `package.json`, `Makefile`, `justfile`, `pyproject.toml`, and `uv.lock`.

## When to Act vs. When to Ask

| Judgment | Action |
|---|---|
| Instruction is clear and change is contained | Act directly |
| Multiple reasonable approaches have different trade-offs | Recommend one with rationale, then ask the user to choose |
| Requirements are ambiguous | Restate understanding and confirm before acting |
| Operation is destructive | Confirm first |
| Feasibility is unclear | State risks and limits first |
| Creating multiple new files or directories | State the plan and file list first |
| Research involves an uncertain or drift-prone domain | Search and verify first |

## Claude Code File Mapping

| Scope | Claude Code file |
|---|---|
| User-level memory and behavior | `~/.claude/CLAUDE.md` |
| Project-level memory and behavior | `{project}/CLAUDE.md` |
| Project settings | `{project}/.claude/settings.json` |
| Project Skills | `{project}/.claude/skills/rd-*/SKILL.md` |
| Project commands, if added later | `{project}/.claude/commands/*.md` |

Do not paste Codex-only `config.toml`, Codex hooks, or Cursor `.mdc` syntax into Claude Code files. Translate behavior to Claude Code's native carriers.

## Spec Injection

Project specifications should be stored in repository files so Claude Code can load the same engineering constraints across sessions.

Before executing design- and implementation-related Skills:

1. Check this `CLAUDE.md` file for project-specific conventions.
2. Check for established design decisions or architectural constraints.
3. Persist durable project decisions in `CLAUDE.md` or a linked project document, not only in chat history.

`CLAUDE.md` is for agents: engineering constraints, scripts, directory conventions, risk points, and verification commands. `README.md` is for humans: what the project is, why it exists, and how to get started.

## Evidence Discipline

- If a fact can be confirmed via code, check the code first.
- If a fact can be confirmed via official documentation, check official docs first.
- If a fact can be confirmed via standards, RFCs, or papers, check the original source first.
- If external verification is unavailable, explicitly state the limitation.
- Distinguish facts, inferences, assumptions, and unresolved questions.

## MCP and Tool Routing

Use external tools for specific evidence or workflow needs, not as a broad default:

- Library, framework, or SDK documentation: prefer official docs or a documentation MCP such as Context7 when configured.
- Current web research: use web search for time-sensitive facts.
- Browser interaction and E2E testing: prefer local test scripts or Playwright when available.
- Cross-repository code analysis: use repository search tools only when they materially improve evidence quality.

## Quality Gates

Before completing research, design, implementation, or review tasks, confirm:

- Key conclusions are supported by evidence, not only inference.
- Key assumptions are explicitly labeled.
- Failure paths and boundary conditions have been covered.
- Unconfirmed points are listed separately.
- Verification actions and results have been recorded.

## R&D Skill Routing

Available project Skills use the `rd-` prefix:

| Skill | Deliverable | Daily work |
|---|---|---|
| `rd-requirements-analysis` | Structured requirements document / PRD | Requirements analysis |
| `rd-technical-writing` | Technical proposal / high-level design / implementation plan | Architecture and planning |
| `rd-detailed-design` | Detailed design document | Interfaces, data models, flows, failures |
| `rd-implement` | Runnable code and tests | Code development |
| `rd-code-review` | Code review findings | Code review |
| `rd-testing` | Test plan, tests, or test report | Unit, integration, system, or E2E testing |
| `rd-deployment` | Deployment runbook / change records | Release and rollback planning |
| `rd-doc-review` | Document review findings | Requirements, proposal, or design review |

Use a Skill when the task matches its trigger conditions. Do not force all Skills into a pipeline.

## Code Quality Constraints

| Constraint | Threshold |
|---|---:|
| Single function or method | <= 50 lines |
| Single file | <= 500 lines |
| Nesting depth | <= 3 levels |
| Function parameters | <= 5 |

Prefer readable, direct code. Add comments only when they explain why something is necessary.

## Security Baseline

- No hardcoded secrets, tokens, API keys, or private relay URLs.
- Do not commit `.env`, private keys, or local machine credentials.
- Validate external inputs.
- Avoid leaking internal details in error messages.
- Confirm dependency versions, licenses, and known vulnerabilities before introducing new dependencies.
- Before committing, check staged changes for suspected secrets, tokens, private keys, connection strings, and `.env` content.

## Completion and Verification

Do not say "done" without verification. Final reporting must distinguish:

- Completed work.
- Verification commands and results.
- Unverified areas.
- Technical debt or temporary compromises.
- Risks and recommended follow-up.
