---
name: rd-feasibility
description: >-
  Use when writing project feasibility studies, feasibility analysis reports,
  option viability assessments, or decision-ready feasibility conclusions. Use
  when business, technical, cost, schedule, compliance, operational, and risk
  feasibility must be evaluated before a technical proposal or high-level
  design. Do not use for detailed design, implementation, testing, or deployment
  execution.
---

# $rd-feasibility

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

### 2. Feasibility Dimensions

Evaluate the option or project across these dimensions:

| Dimension | Check Content |
|-----------|---------------|
| Necessity | problem value, policy/business driver, stakeholder demand |
| Technical feasibility | maturity, integration constraints, data availability, architecture fit |
| Economic feasibility | budget, lifecycle cost, licensing, staffing, procurement |
| Schedule feasibility | milestones, dependencies, review cycles, delivery risks |
| Operational feasibility | maintainability, staffing model, process fit, training needs |
| Security and compliance | regulations, standards, security controls, auditability |
| Risk feasibility | high-risk assumptions, external dependencies, fallback options |

### 3. Candidate Options

- Compare at least two options when a real choice exists
- Include the baseline option, such as maintaining the current process, when relevant
- Explain why any option is excluded before detailed comparison
- Do not present a single preferred option as if alternatives do not exist

### 4. Evidence and Estimation Discipline

- Cite source material for factual claims, version-sensitive facts, standards, and market or cost data
- Mark estimates as estimates and state the estimation basis
- If exact data is unavailable, use ranges and sensitivity analysis instead of false precision
- Clearly label unsupported assumptions and list how to verify them

### 5. Conclusion and Decision Advice

- Provide a clear verdict: feasible / conditionally feasible / not feasible
- State confidence level: high / medium / low
- Explain the minimum conditions required to proceed
- List blocking issues, open questions, and recommended next actions

## Spec Injection Check

Pre-execution checks:

- Project feasibility report template or approval format
- Required financial, compliance, security, or standards review dimensions
- Existing PRD, project background, or stakeholder decision records
- Required terminology, glossary, or document numbering conventions

## MCP Tool Usage

- **web_search / Tavily / Brave Search**: current policy, market, vendor, standards, or cost evidence
- **Context7**: official documentation for technical feasibility claims
- **DeepWiki**: reference architectures when assessing open-source or public systems
- **Sequential Thinking**: multi-option trade-off reasoning and sensitivity checks

## Quality Gates

Pre-delivery checklist:

- [ ] Decision question and scope are explicit
- [ ] Facts, assumptions, estimates, and unresolved questions are separated
- [ ] Core feasibility dimensions are covered or exclusions are justified
- [ ] At least two options are compared when a choice exists
- [ ] Key data and standards claims have source attribution
- [ ] Verdict, confidence, conditions, risks, and next actions are clear
- [ ] No fabricated cost, schedule, benchmark, policy, or standards claims

## Out of Scope

- Do not write detailed design or implementation instructions
- Do not invent financial figures, policy requirements, or standards clauses
- Do not hide infeasibility behind vague phrasing such as "basically feasible"
- Do not turn a feasibility conclusion into a commitment without listing conditions
