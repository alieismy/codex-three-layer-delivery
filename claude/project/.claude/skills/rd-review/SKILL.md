---
name: rd-review
description: >-
  Independently review requirements, feasibility studies, research or tool
  evaluations, technical proposals, detailed designs, standards, technical
  articles, or public-affairs articles. Use when findings must identify location,
  evidence, impact, severity, remediation, and a defensible approval or
  publication verdict. Route primary authoring to the owning creation workflow.
---

# rd-review

Perform an independent, evidence-based review with severity-graded findings, actionable remediation, and a defensible verdict.

## Deliverables

- Findings-first review report
- Verdict and explicit conditions for approval, publication, or re-review
- Optional clause-, claim-, or section-level revision table
- Evidence gaps, unresolved risks, and verification actions

## Select One Review Mode

Read only the reference for the selected target:

| Mode | Target | Reference |
|------|--------|-----------|
| Requirements | PRD / SRS / requirements | [requirements-review.md](references/requirements-review.md) |
| Feasibility | Feasibility study / analysis | [feasibility-review.md](references/feasibility-review.md) |
| Research | research report / open-source, product, or AI-tool evaluation | [research-review.md](references/research-review.md) |
| Proposal | technical proposal / high-level design / construction plan | [proposal-review.md](references/proposal-review.md) |
| Design | detailed design | [design-review.md](references/design-review.md) |
| Standards | standard / specification / guideline / normative clauses | [standards-review.md](references/standards-review.md) |
| Article | technical article / white paper / public-affairs article / fact-check | [article-review.md](references/article-review.md) |

If the target spans modes, identify the primary mode and load one additional reference only for a material secondary section.

## Common Review Framework

### 1. Pin the Review Basis

- Identify the exact target, version, scope, audience, intended decision, and review authority
- Read applicable upstream requirements, decisions, source material, templates, standards, and review policy
- Distinguish a content review from copyediting, fact-checking, compliance checking, and design approval
- Resolve discoverable facts from the materials; ask only for missing authority or intent that blocks the verdict
- Preserve approved intent and separate bounded remediation from redesign or ghostwriting

**Completion criterion:** the exact target, version, scope, mode, authority, upstream basis, and verdict vocabulary are fixed before findings are graded.

### 2. Review on Two Independent Axes

- **Alignment/evidence axis**: Does the target match upstream intent and authoritative evidence?
- **Intrinsic-quality/argument axis**: Is it internally complete, consistent, feasible, logically valid, understandable, and verifiable?
- Apply the mode reference to refine these axes; strength on one axis cannot hide failure on the other
- Track the highest evidence state supporting each behavior claim: documentation, source, static configuration, final generated or effective configuration, runtime, or business/production acceptance. A lower state cannot establish a higher one.

**Completion criterion:** every material section is assessed on both axes or explicitly marked not applicable, and neither axis is collapsed into the other.

### 3. Test Failure Hypotheses

- Classify material assumptions as verified, reasonable but unverified, questionable, or contradicted
- Test the strongest plausible counterexample, failure path, boundary condition, alternative explanation, and evidence gap
- For causal claims, test chronology, mechanism, confounders, and whether evidence supports causation rather than correlation
- Report a finding only when its location, evidence, and impact can be stated; do not manufacture findings to appear thorough

**Completion criterion:** every material assumption and central conclusion has been tested against the strongest plausible counterexample, failure path, boundary condition, or alternative explanation.

### 4. Grade Findings by Impact

| Severity | Meaning |
|----------|---------|
| **Blocker** | Invalidates the decision or publication basis, or makes safe progression impossible without fundamental rework |
| **Critical** | Can materially change scope, correctness, safety, compliance, feasibility, or a central conclusion and must be resolved |
| **Major** | Substantial weakness that should be corrected or explicitly accepted but does not alone invalidate the core result |
| **Minor** | Local improvement with limited effect on the decision, argument, or document usability |

Each finding must include location, axis, problem, evidence, impact, severity rationale, concrete remediation or verification action, and owner/date when known.

**Completion criterion:** every retained finding is reproducible from its location and evidence, has an impact-based severity rationale, and names a bounded corrective or verification action.

### 5. Determine the Verdict

Default document verdicts are **Approved / Conditionally Approved / Rejected**. Article mode may use **Publishable / Publishable after revision / Not publishable**. In either form:

- No unresolved Blocker is compatible with approval or publication
- Unresolved Critical findings normally require rejection or revision before approval
- Conditional approval requires bounded conditions, verification actions, assignment state, and a re-review trigger
- Project policy overrides these defaults; never use a universal issue-count threshold
- A well-supported finding-free or no-change outcome is valid. Do not force remediation when the evidence supports the current state.

**Completion criterion:** the verdict follows from unresolved impact and evidence limits, and every condition has an action, assignment state, and re-review trigger.

## Tool Selection

- Inspect the target and applicable upstream sources before external retrieval
- Use `rd-research` when standards, law, policy, source code, current technology behavior, quotations, timelines, or public facts materially affect a finding
- Prefer primary sources and use independent sources to test self-interested or disputed claims
- If authoritative evidence is inaccessible, narrow the finding and verdict instead of filling the gap
- Redact secrets and unnecessary personal or infrastructure identifiers from findings and evidence excerpts; preserve a controlled source pointer when reviewers need the raw material

## Quality Gates

- [ ] Primary mode, target version, scope, authority, and verdict vocabulary are explicit
- [ ] Evidence/alignment and intrinsic-quality/argument axes were both evaluated
- [ ] Claimed behavior is bounded to the highest evidence state actually established
- [ ] Material assumptions, counterexamples, failure paths, and alternative explanations were tested
- [ ] Every finding has location, evidence, impact, severity rationale, and action
- [ ] Findings lead; strengths and supporting observations follow
- [ ] Verdict follows from unresolved impact and evidence limits, not issue count or reviewer preference
- [ ] No finding or modification is invented when evidence supports no change
- [ ] Facts, quotations, dates, versions, and external claims are verified or explicitly bounded
- [ ] Findings and evidence excerpts contain no secrets or unnecessary sensitive identifiers

## Out of Scope

- Do not redesign or rewrite the whole target during independent review; propose bounded remediation instead
- Do not override well-supported decisions or arguments based on reviewer preference or political agreement
- Do not report style-only findings unless they materially affect meaning, credibility, accessibility, or usability
- Do not fabricate evidence, sources, standards clauses, quotations, owners, dates, or document status
