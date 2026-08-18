# RD Skills Assessment and Evolution

Status: implemented baseline, refreshed 2026-08-07.

## Decision

The original seven Skills were not redundant. They formed a coherent decision-and-document lifecycle: requirements, feasibility, research evidence, solution architecture, detailed design, standards work, and independent review.

The first material role-level gap was source-backed professional writing, which was being forced into `rd-solution` or handled without a repeatable workflow; `rd-writing` now owns that work. A second comparative review against Matt Pocock's Skills and Trellis confirmed a different gap: no Skill owned explicit coordination of a multi-stage, multi-document, or cross-session engagement. This revision adds `rd-delivery` as an explicit orchestration Skill while keeping the other eight specialist Skills independently usable.

## Role Coverage

| User work | Primary Skill | Supporting Skill | Boundary |
|---|---|---|---|
| Product and system requirements | `rd-requirement` | `rd-research`, `rd-review` | proposed technology is not automatically a requirement |
| Project or technology viability | `rd-feasibility` | `rd-research`, `rd-review` | decision analysis, not design or adoption execution |
| Open-source, AI-tool, API, and technology research | `rd-research` | `rd-feasibility`, `rd-review` | evidence first; popularity and demos are not fitness proof |
| VPN, VPS, proxy, network, and system-configuration research | `rd-research` | `rd-solution`, `rd-design` | establish environment, topology, threat boundary, verification, and rollback |
| System and software architecture | `rd-solution` | `rd-research`, `rd-review` | option selection and high-level architecture, not detailed contracts |
| Implementation-ready technical design | `rd-design` | `rd-research`, `rd-review` | design configuration and rollback contracts, not operational commands |
| Standards and normative documents | `rd-specification` | `rd-research`, `rd-review` | authority, applicability, and conformity remain explicit |
| Technical articles, white papers, evidence reports, decision briefs | `rd-writing` | `rd-research`, `rd-review` | audience-ready narrative after evidence is stable |
| Technical or public-affairs fact-checking and argument review | `rd-research`, `rd-review` | `rd-writing` | claim-level evidence and position-neutral review standards |
| Multi-document programs, phase gates, artifact status, and cross-session handoff | `rd-delivery` | only the specialist Skills required by the engagement | explicit orchestration only; never a mandatory pipeline |
| Core code implementation, tests, deployment, security scanning | Codex core workflows and specialized plugins | relevant `rd-*` design inputs | deliberately not duplicated as a generic document Skill |

## Why Nine, Not More

- `rd-delivery` is a user-intent-gated orchestrator, not another authoring domain. It owns artifact maps, blocking edges, phase gates, status, and handoff, while delegating each document to the narrowest specialist Skill.
- `rd-writing` owns narrative composition; `rd-research` owns evidence collection; `rd-review` owns an independent verdict. These trigger boundaries prevent a single Skill from researching, advocating, and approving its own output.
- Open-source and AI-tool research, infrastructure/configuration research, and fact-checking share the same evidence contract. They are modes under `rd-research`, with focused references loaded on demand, rather than three competing top-level Skills.
- Research-report and article review are modes under `rd-review` because they share findings, severity, remediation, and verdict mechanics.
- Coding, deployment execution, browser automation, security scanning, and file-format manipulation already have stronger core or specialist workflows. Adding broad `rd-code` or `rd-operations` Skills would create trigger collisions and weaken ownership.

## External Design Evidence

- The [Agent Skills specification](https://agentskills.io/specification) makes `name` and `description` the discovery layer and recommends progressive disclosure, focused references, validation, and a main file below 500 lines.
- Current [OpenAI Codex skill guidance](https://learn.chatgpt.com/docs/build-skills) says descriptions should front-load the use case because large installed Skill sets may have descriptions shortened or omitted from the initial list. It also documents optional `agents/openai.yaml` metadata for ChatGPT/Codex desktop use.
- The former [openai/skills repository](https://github.com/openai/skills) is marked deprecated for current distribution examples; [openai/plugins](https://github.com/openai/plugins) is the current packaging reference. This repository retains direct Skill folders for cross-client authoring and adapters; plugin packaging is a separate distribution decision.
- Anthropic's [Agent Skills engineering guidance](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) recommends starting from observed capability gaps, evaluating representative tasks, and splitting mutually exclusive context into on-demand resources.
- Matt Pocock's [research Skill](https://github.com/mattpocock/skills/blob/v1.2.3/skills/engineering/research/SKILL.md) reinforces primary-source research and one cited artifact. His renamed [writing-for-agents guidance](https://github.com/mattpocock/skills/blob/v1.2.3/skills/productivity/writing-for-agents/SKILL.md) treats agent instructions as an information-architecture problem: front-load trigger context, load only decision-relevant detail, define exhaustive completion checks, keep one source of truth, and prune duplicated or stale guidance. The 2026-08-07 audit pinned release `v1.2.3` to Commit [`6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`](https://github.com/mattpocock/skills/commit/6acc160e4e0cd062dbbbd7a1b26ae92855edf07e) and independently adapted only mechanisms that fit document delivery.
- [Trellis](https://github.com/mindfold-ai/Trellis) persists scoped specs, task artifacts, verification context, and session handoffs and uses Plan / Implement / Verify / Finish boundaries. This project adapts only the document-delivery mechanisms: authoritative artifacts, decision-complete work packages, phase gates, status discipline, and durable handoff. It does not copy the `.trellis/` directory model, task scripts, coding workflow, or mandatory approval state machine.

## Matt Pocock Skills 1.2.0–1.2.3 Audit

The audit inspected the [`v1.2.0`](https://github.com/mattpocock/skills/releases/tag/v1.2.0) release that introduced portable `agents/openai.yaml` metadata and explicit-only Codex policy, then verified the latest [`v1.2.3`](https://github.com/mattpocock/skills/releases/tag/v1.2.3) tag and source at Commit `6acc160`. Release `v1.2.2` restored model invocation for `writing-for-agents`; `v1.2.3` improved secret redaction and removed Claude-specific subagent wording. No `v1.2.1` GitHub release was present at inspection time.

| Mechanism | Decision | Adaptation in this project |
|---|---|---|
| User-invoked orchestration vs. model-invoked reusable discipline | Adopt | `rd-delivery` remains explicit-only. Codex uses `agents/openai.yaml`; Claude and Cursor adapters use `disable-model-invocation: true`. The standard/Codex Skill roots retain portable `name` and `description` frontmatter. |
| Checkable, demanding completion criteria for each step | Adopt | Every numbered step in all nine canonical Skills now has one English or Chinese completion criterion, and repository validation enforces exactly one criterion inside each step across adapters. |
| Single source of truth; maps and handoffs as indexes rather than stores | Adopt | The delivery record points to authoritative artifacts and decision records instead of duplicating full content. |
| Agent documents as context and cognitive-load routers | Adopt | Project `AGENTS.md` owns stable authority, routing, and completion rules; detailed RD procedures remain solely in the nine Skills. Environment-discoverable facts are checked at use time rather than cached as durable prose. |
| Secret and sensitive-identifier redaction in diagnostics and handoff | Adopt and broaden | Research, writing, review, and delivery now redact secrets and unnecessary personal or infrastructure identifiers while preserving controlled evidence pointers and reproducibility boundaries. |
| Frontier planning under uncertainty | Adopt with document semantics | `rd-delivery` separates ready-to-define work, in-scope work that is not yet precise enough, and out-of-scope work; only precise, independently reviewable outputs become work packages. |
| Facts are retrieved; stakeholder decisions remain human-owned | Retain and strengthen | Requirements now flag evidence and route feasibility decisions instead of making premature verdicts; feasibility records decision authority; the other workflows continue to separate discoverable facts from authorized decisions. |
| Primary-source research in one cited artifact | Already adopted | `rd-research` uses an explicit source hierarchy, counterevidence, version/date context, one canonical evidence package, and downstream handoff. |
| Two-axis review | Already stronger in scope | `rd-review` applies alignment/evidence and intrinsic-quality/argument axes to requirements, feasibility, research, proposals, designs, standards, and articles rather than only code diffs. |
| Router Skill for many manual commands | Do not adopt now | Only `rd-delivery` is explicit-only; the eight specialist Skills are model-invoked and independently triggerable, so a second router would add cognitive and maintenance load without a distinct deliverable. |
| Mandatory background research agents | Do not adopt | Parallel research can be useful, but the Skill must remain correct when subagents are unavailable, unsuitable, or not authorized. |
| Issue-tracker state machines, coding flows, TDD, implementation, and code review | Do not adopt | They conflict with the repository's intentional document-delivery and system-design scope. |
| Tracker-specific maps, ticket labels, assignment claims, and automatic external writes | Do not adopt | Durable repository artifacts and explicit authority are portable; external tracker mutation remains task- and authorization-specific. |

The project does not copy upstream coding, ticket, TDD, wizard, or mandatory-subagent workflows. It adopts portable instruction mechanics only, and keeps the repository's document-delivery and system-design scope authoritative.

## VibeCoding 9.9.6 Reference Audit

The local VibeCoding Codex 9.9.6 tree was reviewed as a design reference, not as an upstream dependency. Its most useful contribution is a set of document-governance mechanisms:

- Keep long-lived need and intent, current-state architecture, engagement-specific change design, decision rationale, evidence, and review findings in distinct authority layers.
- Distinguish reproducible machine gates from human decisions. A waiver requires authorized ownership, rationale, bounded scope, residual risk, and a re-review trigger.
- Return a failed gate to the nearest affected work package instead of restarting unrelated stages; unresolved repeated failure becomes an explicit blocker.
- Invalidate affected downstream reviews and approvals after a material upstream change.
- Validate authoritative pointers and report missing, stale, or repository-escaping paths.
- Promote a rule into durable project guidance only when it is traceable to an explicit requirement, a recurring observed failure, or a material project risk, and has a verification path.

The following mechanisms were deliberately not adopted:

| Candidate | Decision | Reason |
|---|---|---|
| PACE lifecycle and `.ai_state` state machine as a project-wide default | Do not adopt | Coding-oriented and too invasive for this repository's document-delivery scope |
| Athena/Quantum Skill families and named subagents | Do not adopt | Duplicate current specialist ownership and depend on source-specific routing assumptions |
| Full default hook bundle | Do not adopt | Excessive operational surface; native Windows portability and output contracts are not demonstrated |
| `approval_policy = "never"` with `danger-full-access` | Do not adopt | Removes both approval and sandbox boundaries; unsuitable as a public or project default |
| Hard-coded model context and compaction limits | Do not adopt | Model-specific assumptions were not justified by current official configuration evidence |
| Literal text or scripts from the reference tree | Do not adopt | No license, `COPYING`, or `NOTICE` declaration was found; only independently expressed mechanisms were adapted |

The source `config.toml` also failed current schema validation because `windows_wsl_setup_acknowledged` is not a recognized top-level property. The current canonical concurrency key is `agents.max_concurrent_threads_per_session`; `agents.max_threads` is retained only as a legacy alias. An opaque `[desktop]` table may pass schema validation because it permits additional properties, but that does not prove arbitrary keys have runtime effect. These conclusions were checked against the current [Codex config reference](https://learn.chatgpt.com/docs/config-file/config-reference), [configuration schema](https://learn.chatgpt.com/docs/config-schema.json), and [hooks documentation](https://learn.chatgpt.com/docs/hooks).

## Implemented Quality Controls

- Eight positive/near-miss trigger cases per Skill, with at least three cases on each side
- At least three output-quality evals per Skill
- Focused `references/` for research, review, writing, and delivery modes
- `agents/openai.yaml` UI metadata without MCP dependencies; specialist Skills retain default invocation policy
- `rd-delivery` alone disables implicit invocation: by `policy.allow_implicit_invocation: false` for Codex and by `disable-model-invocation: true` in Claude/Cursor adapters
- Global `AGENTS.md` v7.4 keeps truthfulness, response modes, context health, pre-output review, output rules, evidence-state boundaries, no-change legitimacy, task routing, and a compact per-domain baseline active without duplicating full Skill workflows; unavailable or unselected Skills therefore degrade explicitly instead of removing the control plane
- Codex, Claude, and Cursor control surfaces distinguish documentation, source, static/effective configuration, runtime, and production acceptance, and accept a supported no-change conclusion
- Exact English and Chinese adapter mirrors except the validated, platform-specific `rd-delivery` invocation field
- A PowerShell installer limits replacement to the declared nine Skills, verifies backups and staging trees, restores on replacement failure, and supports a read-only exact-tree check
- Repository validation for frontmatter, description boundaries, per-step completion criteria, invocation parity, metadata, evals, Skill set, LF endings, mirror equality, Context7 version consistency, the root maintainer contract, revision-aware context reuse, the greenfield research gate, and the `.tmp/local/` boundary
- A separate ten-case negative regression runner proves the validator rejects completion-criterion misdistribution, Context7 document/config drift, `rd-delivery` invocation-policy regression, loss of the always-on evidence/no-change contract, loss of the RD specialist Skill/eval/near-miss contract, a missing or weakened root maintainer contract, loss of context invalidation and dynamic-state separation, loss of the greenfield research/approval gate, and loss of the `.tmp/local/` boundary

The next meaningful optimization should come from observed false triggers, missed triggers, premature step completion, broken handoffs, duplicate authority records, or low-quality real outputs. Adding another top-level Skill without an independently triggerable deliverable or workflow would be speculative.
