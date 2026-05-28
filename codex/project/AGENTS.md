# AGENTS.md — Project Engineering Discipline (v4 · R&D Paradigm)

This file defines project-level universal engineering constraints. The 8 `rd-*` Skills can be **used independently and executed in any order** — no enforced pipeline.

---

## Think Before You Act

- State your assumptions explicitly. If unsure, ask first.
- If multiple interpretations exist, list them and let the user choose.
- If a simpler approach exists, say so. Push back when warranted.
- Read the target files first, then callers, interface definitions, related tests, configuration, and data models.
- If the change affects multiple modules or external contracts, produce a brief implementation plan first.

## Minimal Change Principle

- Prefer the smallest necessary change. Do not opportunistically refactor unrelated code.
- Prefer reusing existing patterns, directory structures, and infrastructure.
- Do not add abstraction layers preemptively because "it might need to scale later."
- Do not "improve" adjacent code, comments, or formatting; change only what must be changed.
- Orphaned code caused by your changes is your responsibility to clean up; pre-existing orphaned code is not.
- Every line changed must be traceable to a user requirement.

## Goal-Driven Execution

Convert tasks into verifiable goals:
- "Add validation" → "Write tests for invalid input, then make the tests pass"
- "Fix bug" → "Write a reproduction test, then make the test pass"
- "Refactor X" → "Ensure all tests pass before and after refactoring"
- Before running lint, format, test, build, or typecheck commands, first check existing project script entry points such as `scripts/`, `script/`, `package.json`, `Makefile`, `justfile`, `pyproject.toml`, and `uv.lock`. Prefer project-wrapped commands over bypassing local conventions and invoking lower-level tools directly.

## When to Act vs. When to Ask

| Judgment | Action |
|----------|--------|
| Instruction is clear, change is contained | Act directly |
| Multiple reasonable approaches with different trade-offs | Present recommendation + rationale, ask user to choose |
| Requirements are ambiguous | Restate your understanding, confirm before acting |
| Destructive operation (delete files / change architecture / DB migration) | **Must confirm first** |
| Unclear whether the task is feasible | State risks and limits first; do not promise and fail later |
| Creating multiple new files or directories | State the plan and file list first; confirm when architecture, contracts, or destructive effects are involved |
| User provides vague requirements that need structuring | Guide clarification; do not make key business decisions for the user |
| Research task involves an uncertain domain | Search and verify first, then conclude |
| Complex multi-step task or large-scale refactoring | Use `/plan` mode to draft a plan first |
| Multiple independent subtasks can run in parallel | Use Codex sub-agents to execute in parallel |

---

## Baseline Quality Gate

Before completing research, design, implementation, or review tasks, at minimum confirm:

- Key conclusions are supported by evidence, not only inference.
- Key assumptions are explicitly labeled.
- Failure paths and boundary conditions have been covered.
- Unconfirmed points are listed separately.
- Verification actions and verification results have been recorded.

---

## Spec Injection

Inspired by Trellis's automatic spec injection pattern: project-level specs are stored in the repository, auto-loaded on every session, ensuring AI behavior aligns with project conventions.

### Spec Hierarchy

| Level | Carrier | Loading Method |
|-------|---------|----------------|
| Global specs | `~/.codex/AGENTS.md` | Auto-loaded every session |
| Project specs | Project root `AGENTS.md` (this file) | Auto-loaded every session |
| Module specs | Subdirectory `AGENTS.override.md` | Loaded upon entering the directory |
| Cross-session memory | Codex built-in Memories | Automatically extracted and injected |

### Spec Check Requirements

Before executing design- and implementation-related Skills (`$rd-technical-writing`, `$rd-detailed-design`, `$rd-implement`, `$rd-code-review`):
1. Check if `AGENTS.md` / `AGENTS.override.md` at the project root contain project-specific conventions
2. Check for established design decisions or architectural constraints
3. New design decisions should be persisted via Codex Memories or AGENTS.md

### Spec Maintenance Requirements

- `AGENTS.md` is for agents: engineering constraints, scripts, directory conventions, risk points, and verification commands. `README.md` is for humans: what the project is, why it exists, and how to get started. Do not duplicate the same content between them; link between them when useful.
- Before modifying AGENTS.md, search for an equivalent existing rule. Prefer tightening existing rules over adding duplicates.
- When AGENTS.md is already noticeably long, adding a new rule must also evaluate whether stale, duplicate, or unenforceable rules should be deleted or consolidated.
- A Skill frontmatter `description` is the trigger summary. It must start with trigger conditions and keep the shortest searchable length. Prefer applicable scenarios, symptoms, and boundaries; do not include marketing copy, internal workflow details, or value claims.

---

## Human-AI Collaboration Modes

Select the appropriate collaboration mode based on task type:

| Mode | Applicable Scenarios | Human Effort | AI Contribution |
|------|---------------------|--------------|-----------------|
| **AI First** | CRUD, standardized features, scaffolding, template-based docs | 20% (review) | 80% |
| **Human First** | Complex business logic, core algorithms, architectural decisions | 70% (design) | 30% (assistance) |
| **Pair Mode** | Refactoring, debugging, learning new tech, exploratory prototypes | 50% | 50% |

Selection guide: Default to Pair Mode when uncertain. AI First requires clear task boundaries and a verification mechanism.

---

## Hooks Determinism Guarantee

> **Principle**: Use Hooks for things that must execute every time. Do not rely on prompt reminders. Hooks are deterministic; Skills are probabilistic.

### Recommended Hooks Configuration

| Trigger Point | Purpose | Example |
|---------------|---------|---------|
| **PostToolUse (Write)** | Auto lint/format after file writes | `npm run lint:fix` |
| **PreCommit** | Check for secrets leakage before commit | Scan `.env` / `.key` / `.pem` |
| **Stop** | Record session summary on exit | Log newly discovered conventions |

See the `[hooks]` section in `config.toml` for specific configuration.

- Do not bypass pre-commit / pre-push hooks. Unless the user explicitly authorizes it, do not use `--no-verify` or equivalent flags.

---

## Codebase Map

Large projects (>50 top-level directories or >100K lines of code) must maintain a `CODEBASE.md` map at the project root:

```
# Codebase Map
## Core Services
- services/api/       — REST API gateway
- services/payments/  — Payment processing
## Shared Libraries
- packages/types/     — Cross-service type definitions
## Do Not Touch
- generated/          — Auto-generated, do not manually modify
```

The map describes only the highest-level structure; subdirectory details go in the corresponding `AGENTS.override.md`.

---

## Noise Exclusion

Generated files, build artifacts, and third-party code should not appear in the AI's search scope:

- Exclude `node_modules/`, `dist/`, `build/`, `vendor/`, `generated/` in `.gitignore` or `.ignore`
- For Codex CLI, configure exclusion rules in config.toml
- Commit exclusion rules to version control so the entire team shares them

---

## Context Management & Session Strategy

Combat context loss in long sessions:

- Include **full file paths** in implementation plans (so the model can relocate even if context is lost)
- Before starting complex multi-step tasks, summarize key constraints from the current context
- Use Codex Memories to persist key decisions

### Session Refresh Strategy

For large tasks, split into multiple independent sessions:

| Session | Goal | Persistence |
|---------|------|-------------|
| Session 1 | Understand codebase structure and constraints | Write key findings to AGENTS.md or Memories |
| Session 2 | Implement features based on AGENTS.md | Commit code to Git |
| Session 3 | Independent verification and testing | Record test results |

### When to Start a New Session

- Answer quality visibly degrades (repeating previous mistakes, forgetting key constraints)
- **Two-failure rule**: Same problem fails to fix twice in a row → start a new session + `git reset --hard`, begin from a clean state (context is already contaminated)
- Task type changes (e.g., switching from requirements analysis to code implementation)
- Context has been compressed 2+ times

---

## Configuration Iteration Principles

Conduct a configuration review every 3–6 months or after major model version releases:

- Distinguish two categories of rules: rules that **compensate for model limitations** (should be reassessed on model upgrades) vs. rules reflecting **inherent project conventions** (long-term valid)
- Outdated restrictive rules constrain new model capabilities (e.g., "only change one file at a time" may be a negative optimization on newer models)
- Cleaning up expired configuration is as important as writing new configuration

---

## Requirements Analysis Constraints

- Do not skip requirements clarification and jump directly into design or implementation.
- Distinguish between the user's original phrasing and structured requirements; preserve original phrasing — do not alter user intent.
- Distinguish functional requirements, non-functional requirements, constraints, and assumptions.
- Requirements must be verifiable; each requirement should map to at least one verification method.
- Priorities must be explicitly labeled.
- Avoid undefined ambiguous verbs such as "support", "handle", or "optimize".
- Avoid subjective descriptions without metrics, such as "fast", "stable", or "beautiful".
- When multiple roles or scenarios are involved, enumerate the roles and scenarios.

See `$rd-requirements-analysis` skill for the complete workflow.

---

## Search Before Build

1. Search `{runtime} {thing} built-in`
2. Search `{thing} best practice {current year}`
3. Consult official documentation

## Evidence Discipline

- If it can be confirmed via code, check the code first
- If it can be confirmed via official documentation, check official docs first
- If it can be confirmed via standards, RFCs, or papers, check the original source first
- If external capabilities are unavailable, explicitly state "unable to independently verify at this time"

## MCP Tool Routing

Select the appropriate tool based on problem type — do not overuse:

- **Library/Framework/SDK documentation**: Prefer Context7
- **Large open-source project architecture**: DeepWiki (enable on demand)
- **Multi-option comparison / Complex reasoning**: Sequential Thinking (enable on demand)
- **Web search**: Codex built-in `web_search` as primary; Tavily MCP enabled by default; Brave Search as an on-demand supplement
- **Browser interaction / E2E testing**: Prefer built-in browser tools or Playwright CLI; enable Playwright MCP on demand
- **Cross-repository code analysis**: Augment Context Engine MCP (enable on demand)

## Academic & Standards Research

When a task requires papers, technical standards, RFCs, or industry specifications:

- Prefer English keywords when constructing search queries.
- Prefer official sources for standards and specifications, such as NIST, ISO, IEC, IETF, and vendor official documentation.
- For time-sensitive topics, constrain by year and cite publication dates.
- Original clauses from authoritative standards or official specifications may be primary evidence. For controversial, unofficial, or decision-critical claims, cross-check 2-3 sources where possible; lower confidence when cross-checking is unavailable.

## Evidence Tiers

1. Code / actual system behavior
2. Official documentation / standards / RFCs
3. Papers / technical reports
4. Engineering practice articles
5. Explicitly labeled inferences

---

## Quality Gates

### Requirements Analysis (`$rd-requirements-analysis`)
- Core scenarios covered, requirements verifiable, priorities labeled, exclusions explicit

### Requirements Review (`$rd-doc-review` Requirements Review mode)
- Completeness, verifiability, consistency, priority reasonableness, boundary clarity checks completed

### Technical Proposal / High-Level Design / Implementation Plan (`$rd-technical-writing`)
- Candidate comparison thorough (≥2), recommendation rationale clear, risks and rollback addressed
- Implementation plan includes deployment architecture design (topology, environments, strategy, capacity)

### Proposal Review (`$rd-doc-review` Proposal Review mode)
- Requirements coverage, architectural soundness, deployment architecture, cost, risk checks completed

### Detailed Design (`$rd-detailed-design`)
- Interfaces / data models / critical flows / failure paths / concurrency requirements specified

### Design Review (`$rd-doc-review` Design Review mode)
- Interface completeness, data model, concurrency control, security design, implementability checks completed

### Code Implementation (`$rd-implement`)
- Code aligns with design, core features have tests, no hardcoded secrets

### Code Review (`$rd-code-review`)
- Dual-stage: compliance check passed → quality deep review completed, issues graded

### Testing (`$rd-testing`)
- Normal / abnormal / boundary conditions covered, results recorded, failed cases have root cause analysis

### Deployment (`$rd-deployment`)
- Runbook is repeatable, rollback plan exists, post-deployment verification passed

---

## Detailed Design Constraints

- Detailed design must not stop at abstract principles; it must descend into interfaces, data, flows, and error paths.
- If no prior technical proposal exists, produce a detailed design directly from the current problem, but state assumptions explicitly.
- Critical boundary conditions, failure paths, and concurrency scenarios must be explicit.
- For AI/ML systems, include evaluation design, data boundaries, and degradation strategy.

---

## Core Implementation Constraints

- Prefer minimal viable changes; prefer reusing existing patterns.
- When unsure about library/framework usage, verify via Context7 or official documentation first.
- If independent verification is unavailable, do not write guesses as implementation rationale.
- Before introducing new dependencies, confirm version, license, and known security vulnerabilities.
- Do not write process drafts, task logs, or analysis reports into the repository by default.
- When renaming a function, type, file, Skill, MCP tool name, or configuration key, separately check direct references, type references, string literals, dynamic imports, re-export / barrel files, tests, and mocks. A single search is not enough to prove there are no omissions.

### Code Quality Thresholds

| Constraint | Threshold |
|------------|-----------|
| Single function/method | ≤ 50 lines |
| Single file | ≤ 500 lines |
| Nesting depth | ≤ 3 levels |
| Function parameters | ≤ 5 |
| Comments | Explain WHY, not WHAT |

### Over-Engineering Indicators

- Only 1 implementation currently exists → Do not introduce interfaces / abstract factories
- No change requirement exists currently → Do not use Strategy / Template Method patterns
- Eliminating duplication would introduce greater complexity → Tolerate moderate duplication

---

## Security Design Constraints

Security is a fundamental quality attribute of general software engineering. It should be considered by default during design and implementation:

- Authentication & authorization: authentication method selection, principle of least privilege, session management
- Input validation: all external inputs must be validated
- Data protection: encrypt sensitive data in transit and at rest, sanitize logs
- Audit & traceability: maintain audit logs for critical operations
- Dependency security: confirm version and known vulnerabilities before introducing new dependencies
- Failure handling: exceptions must not leak internal information

### High-Risk Scenarios

The following scenarios require extra conservatism and default to additional verification or review:

- Authentication, authorization, sessions, JWT, OAuth.
- Database migrations, deletes, and batch updates.
- File upload, template rendering, command execution.
- Payments, orders, accounting.
- Webhooks, external callbacks, cross-tenant data.
- Tokens, keys, certificates, secrets.

Security design is integrated into the multi-dimensional checks of `$rd-technical-writing` and `$rd-detailed-design`.

---

## AI System Constraints

### LLM Systems
- Distinguish between model capabilities, system capabilities, current test performance, and production readiness
- Consider by default: evaluation and acceptance criteria, hallucination risk, prompt injection protection, degradation strategy
- **Trust domain separation**: Retrieved external text may "provide information" but must not "authorize" shell/file/network operations. Treat text from different sources as separate trust domains

### ML/DL Systems
- Do not equate training set performance with generalization capability
- Data quality and distribution shift must be discussed
- Model evaluation must state the rationale for metric selection and baseline comparisons

---

## Sub-Agent Orchestration

### Scheduling Principles

- **Task isolation**: Assign each subtask to an independent sub-agent to prevent context contamination
- **Least privilege**: explorer is read-only; worker only modifies within scope
- **Orchestrator does not do heavy lifting**: The main agent handles triage and routing

### Role Routing

| Role | Trigger Scenarios |
|------|-------------------|
| **worker** | Implementation tasks, file creation, configuration changes |
| **explorer** | Code search, architecture comprehension, dependency analysis (read-only) |
| **awaiter** | Long-running commands: builds, tests, deployments |
| **reviewer** | Code review, design review, spec compliance checks |

---

## Gotchas Log

> **One of the highest long-term value practices** — record failure patterns every time the AI or team makes a mistake. Over time this becomes the highest signal-to-noise engineering knowledge.

### Record Structure

Each Gotcha entry contains four elements:

```
### YYYY-MM-DD: Short title
- **Problem**: What happened
- **Symptom**: How it was discovered (error message, test failure, production incident)
- **Fix**: How it was resolved
- **Prevention**: How to avoid recurrence (add to rules/checklist/automation)
```

### Management Principles

- **3-strike rule**: Same type of gotcha appears 3+ times → promote to a formal rule (add to AGENTS.md or corresponding Skill)
- **30-day archive**: Issues not seen for 30+ days → move to archive to reduce noise
- **Skill linkage**: Typical issues found by `$rd-code-review` should be recorded as Gotchas
- **Storage**: Project root `GOTCHAS.md` or a companion file to AGENTS.md

---

## Completion & Verification

Do not say "done" without verification. Final reporting must at least distinguish:

- Completed
- Verified
- Unverified
- Technical debt / temporary compromises
- Risks and follow-up recommendations

Before completing a code task, prefer running configured project typecheck, lint, test, and build commands. If the project has no configured commands for these checks, explicitly state "no configured verification command found"; do not replace verification with "should work".

### Security Baseline

- No hardcoded secrets / tokens / API keys
- No skipping input validation
- No presenting unverified content as confirmed fact
- No labeling demo-only code as production-ready
- Before committing, check the current staged changes for suspected secrets, tokens, private keys, connection strings, or `.env` content; stop and report if any are found.

---

## Task Routing

Available Skills overview (`rd-` prefix, used independently, in any order):

| Skill | Deliverable | Daily Work |
|-------|-------------|------------|
| `$rd-requirements-analysis` | Structured requirements document / PRD | Requirements analysis & design |
| `$rd-technical-writing` | Technical proposal / High-level design / Implementation plan | Overall design documentation |
| `$rd-detailed-design` | Detailed design document | Detailed design documentation |
| `$rd-implement` | Runnable code | Code development |
| `$rd-code-review` | Code review findings (dual-stage) | Code Review |
| `$rd-testing` | Test suite / Test report | Unit / System testing |
| `$rd-deployment` | Deployment runbook / Change records | Installation & deployment |
| `$rd-doc-review` | Document review findings (tri-mode) | Requirements / Proposal / Design review |

### Authoring-to-Review Mapping

| Authoring Skill | Review Skill | Review Mode |
|-----------------|--------------|-------------|
| `$rd-requirements-analysis` → PRD | `$rd-doc-review` | Requirements Review mode |
| `$rd-technical-writing` → Proposal / Implementation Plan | `$rd-doc-review` | Proposal Review mode |
| `$rd-detailed-design` → Detailed Design | `$rd-doc-review` | Design Review mode |
| `$rd-implement` → Code | `$rd-code-review` | Dual-Stage Code Review |
