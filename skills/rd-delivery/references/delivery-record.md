# Delivery Record Template

Use this template only for multi-stage or cross-session work. Adapt it to the repository's existing document conventions and omit sections that do not affect resumption, review, or authority.

## Header

- Engagement ID:
- Title:
- Goal:
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

## Current State and Authoritative Pointers

- Current phase:
- Current work package:
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

## Decision Log

| ID | Decision | Alternatives | Rationale / evidence | Consequences | Authority | Date | Affected artifacts |
|---|---|---|---|---|---|---|---|

## Evidence and Open Issues

| ID | Claim / issue | Evidence or gap | Impact | Verification action | Owner | Due / state |
|---|---|---|---|---|---|---|

## Phase Gate

- Phase:
- Gate type: machine check / human decision
- Entry conditions met:
- Checks performed:
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
