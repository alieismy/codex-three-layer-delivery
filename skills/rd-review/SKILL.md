---
name: rd-review
description: >-
  Use when independently reviewing a PRD, requirements document, feasibility
  report, technical proposal, high-level design, detailed design, standard, or
  specification. Apply when evidence-based findings, impact severity, and an
  approval verdict are required. Do not use when the primary goal is authoring
  or revising the document, implementing code, testing, or deployment.
---

# rd-review

Perform an independent, evidence-based document review with severity-graded findings, actionable remediation, and a defensible verdict.

## Deliverables

- Findings-first review report
- Verdict: Approved / Conditionally Approved / Rejected
- Optional clause-level or section-level revision table
- Explicit evidence gaps and conditions for re-review

## Select One Review Mode

Read only the reference for the selected target:

| Mode | Target | Reference |
|------|--------|-----------|
| Requirements | PRD / SRS / requirements | [requirements-review.md](references/requirements-review.md) |
| Feasibility | Feasibility study / analysis | [feasibility-review.md](references/feasibility-review.md) |
| Proposal | Technical proposal / high-level design / construction plan | [proposal-review.md](references/proposal-review.md) |
| Design | Detailed design | [design-review.md](references/design-review.md) |
| Standards | Standard / specification / guideline / normative clauses | [standards-review.md](references/standards-review.md) |

If the target spans modes, identify the primary mode and load an additional reference only for a material secondary section.

## Common Review Framework

### 1. Pin the Review Basis

- Identify the exact target, version, scope, audience, and intended decision
- Read applicable upstream requirements, decisions, templates, standards, and review policy
- Resolve discoverable facts from the materials; ask the user only for missing authority, intent, or decisions that block the verdict
- Preserve the document's approved intent; do not silently redesign it

### 2. Review on Two Axes

- **Alignment axis**: Does the document faithfully satisfy upstream intent, approved decisions, and authoritative sources?
- **Intrinsic-quality axis**: Is the document internally complete, consistent, feasible, traceable, understandable, and verifiable?
- Keep the axes distinct so strength on one cannot hide failure on the other

### 3. Test Failure Hypotheses

- Surface material assumptions and classify them as verified, reasonable but unverified, questionable, or contradicted
- Test the strongest plausible counterexample, failure path, boundary condition, and evidence gap
- Report a finding only when its location, evidence, and impact can be stated; do not manufacture findings to appear thorough

### 4. Grade Findings by Impact

| Severity | Meaning |
|----------|---------|
| **Blocker** | Invalidates the decision basis or makes safe progression impossible without fundamental rework |
| **Critical** | Material defect that must be resolved before approval because it can change scope, correctness, safety, compliance, or feasibility |
| **Major** | Substantial weakness that does not by itself invalidate the core decision but should be corrected or explicitly accepted |
| **Minor** | Local improvement with limited effect on the decision or document usability |

Each finding must include:

- Location
- Axis: alignment / intrinsic quality / both
- Problem and evidence
- Impact and severity rationale
- Concrete remediation or verification action
- Owner or target date when known; otherwise mark unassigned or unconfirmed

### 5. Determine the Verdict

| Verdict | Conditions |
|---------|------------|
| **Approved** | No unresolved Blocker or Critical; remaining issues do not undermine the intended decision and are explicitly tracked |
| **Conditionally Approved** | No Blocker; bounded unresolved issues have explicit conditions, verification actions, assignment state, and re-review trigger |
| **Rejected** | A Blocker exists, or unresolved Critical findings make the decision basis materially unsound |

Project or organizational review policy overrides this default. Never use a universal issue-count threshold.

## Tool Selection

- Inspect the target and applicable upstream sources before external retrieval
- Use `rd-research` when standards, law, policy, market facts, or current technology behavior materially affect a finding
- Prefer primary sources and configured tools; reference architectures are examples, not review authority
- If authoritative evidence is inaccessible, limit the claim and mark it for human verification

## Quality Gates

- [ ] Correct primary mode and review basis are explicit
- [ ] Alignment and intrinsic-quality axes were both evaluated
- [ ] Material assumptions, counterexamples, and failure paths were tested
- [ ] Every finding has location, evidence, impact, severity rationale, and action
- [ ] Findings lead; strengths and supporting observations follow
- [ ] Verdict follows from unresolved impact, not issue count or reviewer preference
- [ ] External claims are verified, cited, or explicitly bounded

## Out of Scope

- Do not redesign the document during review; propose bounded remediation instead
- Do not override well-supported decisions based on reviewer preference
- Do not report style-only findings unless they materially affect interpretation or usability
- Do not fabricate standards clauses, source evidence, owners, dates, or document status
