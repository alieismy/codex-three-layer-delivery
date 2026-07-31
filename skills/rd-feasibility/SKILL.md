---
name: rd-feasibility
description: >-
  Evaluate whether a project, product, open-source component, AI tool,
  infrastructure change, or candidate option is viable, and produce a
  decision-ready feasibility conclusion. Use when technical, economic, schedule,
  operational, security, compliance, and risk evidence must be compared before
  commitment. Do not use for requirements, design, review, or execution.
---

# rd-feasibility

Produce **decision-ready feasibility studies** that distinguish confirmed facts, assumptions, estimates, and unresolved verification needs.

## Deliverables

- Feasibility study / feasibility analysis report
- Feasibility comparison matrix
- Recommended conclusion: feasible / conditionally feasible / not feasible
- Risk register with mitigation and verification actions

## Execution Steps

### 1. Study Scope Confirmation

- Clarify the decision question: what needs to be judged feasible or infeasible
- Identify the target audience: decision-makers, project approval committee, client reviewers, technical leadership
- Confirm input sources: PRD, meeting notes, existing system documents, standards, policies, budgets, schedules
- Separate facts from assumptions before evaluating feasibility

**Completion criterion:** the decision question, comparison scope, audience, source set, facts, assumptions, and evidence gaps are explicit.

### 2. Feasibility Dimensions

Evaluate the option or project across these dimensions:

| Dimension | Check Content |
|-----------|---------------|
| Necessity | problem value, policy/business driver, stakeholder demand |
| Technical feasibility | maturity, compatibility, integration constraints, data availability, architecture fit |
| Economic feasibility | budget, lifecycle cost, licensing, staffing, procurement |
| Schedule feasibility | milestones, dependencies, review cycles, delivery risks |
| Operational feasibility | installability, maintainability, staffing model, process fit, training, support and rollback |
| Security and compliance | regulations, standards, privacy, supply-chain exposure, security controls, auditability |
| Sustainability | upstream maintenance, release cadence, licensing, vendor or community dependency, exit path |
| Risk feasibility | high-risk assumptions, external dependencies, failure modes, fallback options |

**Completion criterion:** every material dimension is assessed against evidence or explicitly excluded with a reason; no missing dimension is silently treated as favorable.

### 3. Candidate Options

- Compare at least two options when a real choice exists
- Include the baseline option, such as maintaining the current process, when relevant
- Explain why any option is excluded before detailed comparison
- Do not present a single preferred option as if alternatives do not exist

**Completion criterion:** every real option and relevant current-state baseline is either compared on common criteria or excluded with a documented basis.

### 4. Evidence and Estimation Discipline

- Cite source material for factual claims, version-sensitive facts, standards, and market or cost data
- Mark estimates as estimates and state the estimation basis
- If exact data is unavailable, use ranges and sensitivity analysis instead of false precision
- Clearly label unsupported assumptions and list how to verify them
- For open-source or AI-tool choices, distinguish repository activity from maintainability, demos from reproducible capability, and model capability from product or system capability

**Completion criterion:** every decision-material fact, estimate, and assumption is traceable to a source or estimation basis, or carries a verification action and an explicit effect on confidence.

### 5. Conclusion and Decision Advice

- Provide a clear verdict: feasible / conditionally feasible / not feasible
- State confidence level: high / medium / low
- Explain the minimum conditions required to proceed
- List blocking issues, open questions, and recommended next actions

**Completion criterion:** the verdict, confidence, proceed conditions, blockers, residual risks, and next verification actions follow from the comparison rather than from preference.

## Spec Injection Check

Pre-execution checks:

- Project feasibility report template or approval format
- Required financial, compliance, security, or standards review dimensions
- Existing PRD, project background, or stakeholder decision records
- Required terminology, glossary, or document numbering conventions

## Tool Selection

- Use `rd-research` for current policy, standards, market, vendor, cost, or technical-maturity evidence
- Prefer primary sources and the narrowest configured retrieval capability
- Use library/API documentation retrieval only when current interface or compatibility facts affect feasibility
- Separate unavailable evidence from analysis and make the verification action explicit

## Quality Gates

Pre-delivery checklist:

- [ ] Decision question and scope are explicit
- [ ] Facts, assumptions, estimates, and unresolved questions are separated
- [ ] Core feasibility dimensions are covered or exclusions are justified
- [ ] At least two options are compared when a choice exists
- [ ] Key data and standards claims have source attribution
- [ ] Verdict, confidence, conditions, risks, and next actions are clear
- [ ] Compatibility, lifecycle, security, support, and exit-path concerns are covered when technology adoption is in scope
- [ ] No fabricated cost, schedule, benchmark, policy, or standards claims

## Out of Scope

- Do not write detailed design or implementation instructions
- Do not invent financial figures, policy requirements, or standards clauses
- Do not hide infeasibility behind vague phrasing such as "basically feasible"
- Do not turn a feasibility conclusion into a commitment without listing conditions
