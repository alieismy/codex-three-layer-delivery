# Delivery Record Template

Use this template only for multi-stage or cross-session work. Adapt it to the repository's existing document conventions and omit sections that do not affect resumption, review, or authority.

## Header

- Engagement ID:
- Title:
- Goal:
- Current project stage / responsibility:
- Primary outcome / shortest evidence path:
- Audience / decision:
- Scope:
- Exclusions:
- Governing date / version:
- Delivery owner:
- Approval authority:
- Last updated:

## Artifact Map

| ID | Artifact | Source-of-truth path | Status | Upstream inputs | Downstream use | Owner / authority | Exit gate |
|---|---|---|---|---|---|---|---|

Allowed status vocabulary should be project-defined. When no vocabulary exists, use:

- `Draft`
- `In Review`
- `Conditionally Accepted`
- `Approved`
- `Baselined`
- `Blocked`
- `Superseded`
- `Waived`

Do not infer `Approved` or `Baselined`; record the authority and evidence.
Use `Waived` only for an authorized, bounded exception. Record the approving authority, rationale, residual risk, expiry or scope, and re-review trigger.
Treat this record as an index. Keep full artifact and decision content in one authoritative location; use a concise gist and a resolvable path or URL here instead of maintaining a second copy.

## Current State and Authoritative Pointers

- Current phase:
- Current work package:
- Current verification depth: preflight / changed surface / related regression / full or release
- Next eligible action:
- Latest authoritative requirement:
- Latest authoritative evidence package:
- Latest approved decision or architecture:
- Latest review:

Validate every non-empty pointer before handoff. Report a pointer as missing, stale, or outside the intended repository boundary instead of silently following it.

## Work Packages

| ID | Decision-complete output | Blocked by | Verification | Status | Next action |
|---|---|---|---|---|---|

A work package should be independently reviewable and bounded enough for one focused session. Split by a verifiable decision or deliverable, not merely by document headings.

## Not Yet Specified

| ID | In-scope item | Blocking decision or evidence | Becomes precise when | Owner / authority | State |
|---|---|---|---|---|---|

List in-scope work that cannot yet be stated as a precise, independently reviewable work package. For each item, record the blocking decision or evidence and the condition that would make the completion question precise. Move it into Work Packages only after that condition is met.

## Out of Scope

| ID | Excluded item | Scope decision or rationale | Authority | Re-entry condition |
|---|---|---|---|---|

List material items deliberately excluded from the engagement and the scope decision or rationale. These items do not enter the work frontier unless an authorized scope change explicitly brings them back in.

## Decision Log

| ID | Decision gist | Basis or authoritative record | Consequences | Authority | Date | Affected artifacts |
|---|---|---|---|---|---|---|

When no separate decision record exists, this table may be authoritative; record the alternatives and rationale needed to understand the decision in the basis cell. When an ADR, approval record, or another authoritative decision artifact exists, link it in that cell and do not restate its full content here.

## Evidence and Open Issues

| ID | Claim / issue | Evidence or gap | Impact | Verification action | Owner | Due / state |
|---|---|---|---|---|---|---|

## Phase Gate

- Phase:
- Gate type: machine check / human decision
- Entry conditions met:
- Checks performed:
- Why this verification depth is proportionate:
- Evidence:
- Findings:
- Exit decision:
- Decision authority:
- Waiver, scope, and residual risk:
- Failure return target:
- Re-review trigger:

## Handoff

- Completed:
- Verified:
- Changed decisions:
- Unverified or blocked:
- Current source-of-truth artifacts:
- Resolved blockers / next frontier:
- Required owner decisions:
- Exact next verification actions:
