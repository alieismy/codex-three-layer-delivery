# CLAUDE.md - Project Document Delivery Discipline (v4)

This file defines project-level constraints for Claude Code in document-centered system design work. The `rd-*` Skills are independent and can be used in any order; they are not a forced pipeline.

This adapter intentionally excludes coding, code review, test authoring/execution, deployment execution, and release operations.

## Think Before You Write

- State assumptions explicitly when they affect requirements, feasibility, design, standards, or review conclusions.
- If multiple interpretations affect scope, cost, compliance, or architecture, list them and ask the user to choose.
- Read target documents first, then upstream requirements, feasibility reports, proposals, standards, glossaries, review comments, and constraints.
- Preserve source text before restructuring it. Do not silently rewrite user intent, clause wording, or stakeholder decisions.

## Scope Locking

- Prefer the smallest document change that satisfies the task.
- Reuse existing templates, terminology, numbering, review tables, and document structure.
- Do not add sections, frameworks, or process overhead unless they improve traceability, reviewability, or decision quality.
- Every changed line must trace back to the user's request or a necessary consistency update.

## Goal-Driven Execution

| Request | Verifiable goal |
|---|---|
| Analyze requirements | PRD/SRS items with priorities, assumptions, exclusions, and acceptance criteria |
| Assess feasibility | Feasible / conditionally feasible / not feasible conclusion with evidence, conditions, and risks |
| Write proposal | Candidate solution comparison and justified recommendation |
| Write detailed design | Interfaces, data, flows, errors, security, and unresolved decisions |
| Write professional article or brief | Audience-ready claims with evidence, counterarguments, and bounded conclusions |
| Review document | Severity-graded findings with evidence, impact, and recommendations |
| Review standard | Exact clause references and normative replacement wording where possible |

Before running validation commands, inspect existing project entry points such as `scripts/`, `package.json`, `Makefile`, `justfile`, or document-specific tooling.

## When to Act vs. Ask

| Judgment | Action |
|---|---|
| Instruction is clear and contained | Act directly |
| Multiple document structures or solution paths have different trade-offs | Recommend one with rationale, then ask |
| Ambiguity affects scope, cost, compliance, risk, or architecture | Restate understanding and ask |
| Operation is destructive or changes authoritative baselines | Confirm first |
| Evidence is unavailable for a factual or standards claim | State known facts and verification gaps |
| Research involves uncertain or drift-prone facts | Search and verify first |

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

Before executing document-delivery Skills:

1. Check this `CLAUDE.md` for document conventions.
2. Check existing templates, glossaries, naming rules, review forms, and approved examples.
3. Check upstream decisions, requirements, feasibility conclusions, standards references, and architecture constraints.
4. Persist durable decisions in `CLAUDE.md` or linked project documents, not only in chat history.

`CLAUDE.md` is for agents: stable document-delivery constraints, directory conventions, risk points, and verification commands. `README.md` is for humans: what the project is, why it exists, and how to get started.

## Evidence Discipline

- If a fact can be confirmed from the target document, cite the document first.
- If a fact can be confirmed via official documentation, standards, laws, regulations, RFCs, or papers, check the original source first.
- Distinguish facts, assumptions, estimates, inferences, and unresolved questions.
- For standards work, do not invent clauses, document status, publication dates, or authority. Mark missing evidence as requiring human verification.

## MCP and Tool Routing

Use external tools for specific evidence needs:

- Library, framework, or SDK documentation: official docs or Context7 when configured.
- Current web research: web search for time-sensitive facts.
- Open-source architecture reference: DeepWiki on demand.
- Complex multi-option reasoning: native reasoning first; Sequential Thinking on demand.
- Standards or policy verification: official standards bodies, regulators, or vendor official documentation first.

## Quality Gates

Before completing requirements, feasibility, design, standards, or review work, confirm:

- Key conclusions are supported by evidence.
- Facts, assumptions, estimates, inferences, and unknowns are separated.
- Relevant boundary conditions, compliance constraints, and risks are covered.
- Unconfirmed points are listed with verification actions.
- Final output distinguishes completed work, verification performed, unverified areas, evidence limits, risks, and follow-up.

## Document Skill Routing

| Skill | Deliverable | Daily work |
|---|---|---|
| `rd-requirement` | Structured requirements / PRD / SRS | Requirements analysis and product/design input |
| `rd-feasibility` | Feasibility study / feasibility analysis report | Project feasibility and decision support |
| `rd-research` | Evidence package / research notes / fact-check matrix | Standards, open source, AI tools, configuration behavior, and contested claims |
| `rd-solution` | Technical proposal / high-level design / construction plan | System architecture and solution documentation |
| `rd-design` | Detailed design document | Interface, data, flow, error, security, and concurrency design |
| `rd-specification` | Standards/specification draft or clause revision | Standards formulation, revision, and normative wording work |
| `rd-writing` | Technical article / evidence report / decision brief | Audience-ready, source-backed professional writing |
| `rd-review` | Independent review findings | Engineering documents, research reports, standards, and article review |
| `rd-delivery` | Delivery charter / artifact map / phase gates / handoff | Explicit multi-stage and cross-session orchestration |

Use a specialist Skill when the task matches its trigger conditions. Do not force them into a pipeline. Use `rd-research` for external or contested evidence, `rd-writing` for audience-ready narrative, and `rd-review` for an independent verdict. Use `rd-delivery` only when the user explicitly asks to coordinate multiple artifacts, phase gates, or a durable handoff.

For `rd-delivery`, keep long-lived needs, current-state architecture, engagement-specific change design, decision rationale, evidence, and review findings in distinct authority layers. Distinguish reproducible machine checks from explicit human decisions; record authorized waivers and re-review triggers; invalidate affected downstream reviews after material upstream changes; and reject stale, missing, or repository-escaping authoritative pointers.

## Security and AI System Design

Security is a design quality attribute:

- authentication and authorization model;
- data protection and privacy;
- input/data validation expectations;
- auditability and traceability;
- failure handling and information disclosure boundaries;
- compliance and standards alignment.

For AI/ML systems, distinguish model capability, system capability, evaluation result, and production readiness. Include evaluation design, hallucination risk, prompt-injection risk, data boundary, and fallback strategy when relevant.

## Completion and Verification

Do not say "done" without verification. Final reporting must distinguish:

- Completed work.
- Verification performed.
- Unverified areas.
- Evidence limitations.
- Risks and recommended follow-up.
