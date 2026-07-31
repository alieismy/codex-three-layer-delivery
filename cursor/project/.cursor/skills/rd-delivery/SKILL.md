---
name: rd-delivery
description: >-
  Coordinate a multi-stage, multi-document decision or design engagement across
  requirements, research, feasibility, solution, design, specification, writing,
  and review. Use when the user explicitly requests an end-to-end workflow,
  document package, phased delivery plan, cross-session handoff, or artifact and
  decision traceability. Do not use for a single document or coding/deployment execution.
disable-model-invocation: true
---

# rd-delivery

Coordinate a bounded document-delivery engagement without replacing the specialist `rd-*` Skills that produce or review each artifact.

## Deliverables

- Delivery charter or task capsule
- Artifact, dependency, and decision map
- Phase plan with entry and exit gates
- Status and verification record
- Cross-session or cross-agent handoff

For a durable engagement record, read [delivery-record.md](references/delivery-record.md). Use the repository's existing location and naming conventions; do not impose a new task directory or framework when none is needed.

## Operating Rules

- Use this Skill only for explicit orchestration requests; route a single deliverable directly to its specialist Skill
- Select only the stages required by the decision and deliverables; never force all `rd-*` Skills into a pipeline
- Treat project files as the source of truth and chat as transient working context
- Keep authority explicit: an agent may draft, verify, or recommend, but only an authorized stakeholder can approve or baseline an artifact
- Load the smallest relevant context set for the current stage, then refresh it at each phase boundary
- Keep durable artifact classes distinct: long-lived need and intent, current-state architecture, engagement-specific change design, decision rationale, evidence, and review findings must not silently substitute for one another
- Treat the delivery record as an index, not a second copy of its artifacts: keep status and concise decision context in the record, and link to the one authoritative location for full content

## Workflow

### 1. Frame the Engagement

- State the real decision or delivery goal, audience, scope, exclusions, success criteria, authority, and date/version boundary
- Inspect existing project guidance, document maps, templates, glossaries, baselines, upstream decisions, and active work records
- Separate repository-answerable facts from user-owned scope, priority, risk, and approval decisions
- When iterative clarification is practical, ask one highest-impact unresolved decision at a time with a recommendation and trade-off; batch only independent questions when delay would materially harm progress

**Completion criterion:** the target deliverables, governing inputs, decision owners, and blocking unknowns are explicit.

### 2. Build the Artifact and Dependency Map

For each required artifact, record:

- identifier, title, owner or authority, status, and source-of-truth path
- upstream inputs and downstream consumers
- applicable specialist Skill and review mode
- blocking decisions, evidence, dependencies, and verification method

Use decision-complete slices for large engagements: each work package should produce an independently reviewable result, fit a bounded work session, and declare its blocking edges. Do not split work only by document section when that would leave an unverifiable fragment.

Separate three states while mapping work:

- **Ready to define:** the output and completion question are precise enough to form a work package
- **Not yet specified:** the item is in scope but depends on unresolved decisions or evidence before it can be defined precisely
- **Out of scope:** the item lies beyond the engagement goal and does not become eligible unless the scope is explicitly changed

Promote an item from not yet specified only when its completion question and blocking edges become precise. Keep out-of-scope items separate so they cannot silently enter the work frontier.

**Completion criterion:** every planned artifact has a purpose, owner, status, prerequisites, exit gate, and downstream handoff; every other known material item is explicitly not yet specified or out of scope.

### 3. Execute the Required Stages

Route work to the narrowest matching Skill:

| Need | Skill |
|------|-------|
| PRD, SRS, or structured requirements | `rd-requirement` |
| Decision-ready viability judgment | `rd-feasibility` |
| External, current, disputed, or repository evidence | `rd-research` |
| Option selection and high-level architecture | `rd-solution` |
| Implementation-ready contracts and detailed design | `rd-design` |
| Normative clauses or standards work | `rd-specification` |
| Audience-ready professional narrative | `rd-writing` |
| Independent findings and verdict | `rd-review` |

Before each stage, load its authoritative upstream artifacts and applicable scoped rules. After each stage, record outputs, changed decisions, unresolved items, verification performed, and the next eligible work packages.

**Completion criterion:** each produced artifact satisfies its specialist Skill's quality gate and has a recorded status; downstream work does not consume an unmarked draft as an approved baseline.

### 4. Verify at Phase Boundaries

- Check requirements and decision traceability, terminology, versions, evidence boundaries, and artifact consistency
- Classify each gate as either a machine check or a human decision. Machine checks require reproducible evidence; human decisions require an explicit actor, decision, date, and conditions
- Use `rd-review` when an independent verdict is required; author self-checks do not substitute for independent review
- Re-open upstream decisions when downstream evidence contradicts them instead of silently patching the later document; a material upstream change invalidates affected downstream approvals or reviews until they are repeated
- Allow a gate to be waived only by an authorized decision owner, with rationale, bounded scope, residual risk, and a re-review trigger
- When a gate fails, return to the nearest affected work package or decision rather than restarting unrelated stages; repeated unresolved failure becomes an explicit blocker
- Re-run affected checks after material changes and record what remains unverified

**Completion criterion:** the phase exit decision follows explicit evidence, findings, authority, and unresolved-risk rules.

### 5. Close or Hand Off

- Summarize completed, verified, conditionally accepted, blocked, superseded, and unverified artifacts
- Record decisions with rationale, alternatives, consequences, and authority; create an ADR only when the decision is hard to reverse, surprising without context, and based on a real trade-off
- Promote only stable, reviewed conventions or decisions into durable project guidance; keep temporary notes and session logs out of `AGENTS.md`
- Provide the next frontier: work packages whose blockers are resolved, required owner decisions, and exact verification actions

**Completion criterion:** another reviewer or future session can resume from repository artifacts without reconstructing material context from chat or reconciling duplicate decision records.

## Quality Gates

- [ ] Orchestration was explicitly requested and is not replacing a single specialist Skill
- [ ] Goal, scope, authority, success criteria, and date/version boundary are explicit
- [ ] Artifact statuses, source-of-truth paths, dependencies, and blocking edges are current
- [ ] Ready-to-define, not-yet-specified, and out-of-scope work remain distinct
- [ ] Only required stages were selected
- [ ] Each phase has checkable entry and exit conditions
- [ ] Machine checks, human decisions, and authorized waivers are distinguished and evidenced
- [ ] Draft, reviewed, approved, baselined, superseded, and blocked states are not conflated
- [ ] Authoritative pointers resolve to current in-scope artifacts; stale, missing, or escaping paths are reported rather than followed
- [ ] Material decisions, evidence gaps, verification results, and next actions are durable and traceable
- [ ] Full artifact or decision content has one authoritative location; the delivery record points to it instead of duplicating it
- [ ] Handoff can be understood without relying on hidden chat history

## Out of Scope

- Do not create a parallel repository framework when existing project conventions are sufficient
- Do not force a PRD-to-design pipeline for small or single-document work
- Do not claim stakeholder approval, publication, deployment, or runtime success without evidence and authority
- Do not implement code, run deployment operations, or manage production changes
