---
name: rd-solution
description: >-
  Convert approved requirements or feasibility inputs into a technical
  proposal, high-level design, solution architecture, outline design, or
  construction plan. Use when real alternatives, architecture decisions,
  operating boundaries, and a design-ready recommendation are needed for
  software, infrastructure, networking, or AI-enabled systems. Route feasibility,
  detailed design, independent review, prose-first writing, and execution to
  their owning workflows.
---

# rd-solution

Produce decision-ready **technical proposals, high-level designs, solution architecture documents, and construction plans**.

## Deliverables

- Technical proposal / High-level design / Solution architecture document
- Construction plan or design-oriented project plan
- Candidate solution comparison matrix
- Recommended solution with risk statement
- Architecture decision record inputs for material choices

## Execution Steps

### 1. Objective & Constraint Confirmation

- Clarify the document type (technical proposal / high-level design / solution architecture / construction plan)
- Confirm the audience (decision-makers / technical team / client reviewers)
- Confirm constraints: timeline, budget, tech stack, compliance requirements
- Check for existing requirements documents (`rd-requirement` output)
- Check for feasibility inputs (`rd-feasibility` output) when the project has an approval phase
- Resolve discoverable facts from project artifacts; ask the user only for material decisions that remain open
- Use established domain terminology and surface conflicts instead of silently creating synonyms

**Completion criterion:** the target document, audience, approved inputs, constraints, open decisions, and terminology basis are explicit enough to generate real alternatives.

### 2. Solution Research & Candidate Generation

- Generate at least **2 candidate solutions** when a real architectural or technical choice exists
- Each solution should include: architecture overview, core components, data/interface boundaries, technology choices, deployment or operating assumptions
- Route decision-material maturity, compatibility, policy, cost, or current-version claims to `rd-research`; do not turn candidate generation into an unbounded search phase
- For infrastructure, networking, proxy, VPN, VPS, or AI-tool solutions, model trust boundaries, control/data flows, credential ownership, platform/version constraints, observability, recovery, and exit path

**Completion criterion:** every real decision has at least two viable candidates or a documented reason only one remains, and each candidate states the same material boundaries and assumptions.

### 3. Multi-Dimensional Cross-Check

Evaluate each candidate solution across the following dimensions:

| Dimension | Check Content |
|-----------|---------------|
| Functional completeness | Does it cover all P0/P1 requirements? |
| Performance | Capacity planning, bottleneck prediction, scaling path |
| Reliability | Fault tolerance, disaster recovery, data consistency strategy |
| Security | Authentication & authorization, input validation, data protection, auditing |
| Maintainability | component ownership, observability, operational complexity |
| Cost | Development cost, operational cost, licensing fees |
| Risk | Technical risk, staffing risk, schedule risk, external dependency risk |
| Exit path | Alternative path if the recommended solution is rejected or fails validation |
| Verifiability | Evidence, prototype, compatibility check, or acceptance method needed before commitment |

**Completion criterion:** every candidate is compared on the same decision-relevant dimensions, with missing evidence and non-comparable criteria visible.

### 4. Recommendation & Decision Guidance

- Provide recommendations based on quantitative or semi-quantitative comparison
- Clearly state the rationale for the recommendation and the reasons for rejecting alternatives
- Label the recommendation confidence level (High / Medium / Low) with supporting basis
- State residual risks and items requiring further confirmation

**Completion criterion:** the recommendation, rejected alternatives, confidence, residual risks, and verification actions required before committing to the option are traceable to the comparison.

### 5. Structured Document Output

Select the appropriate template based on document type:

#### Technical Proposal / High-Level Design

```
1. Background & Objectives
2. Requirements Summary (referencing requirements document)
3. Constraints
4. Candidate Solutions
   4.1 Solution A
   4.2 Solution B
5. Solution Comparison
6. Recommended Solution
7. Architecture Design (detailed description of recommended solution)
8. Key Risks & Mitigation Measures
9. Construction / Delivery Milestones
10. Open Issues
```

#### Construction Plan (Design-Oriented)

```
1. Background & Objectives
2. Requirements Summary
3. Constraints
4. Candidate Solutions & Comparison
5. Recommended Solution
6. System Architecture Design
7. Deployment Architecture Design
   7.1 Infrastructure Topology (network, compute, storage)
   7.2 Environment Planning
   7.3 Deployment Strategy at design level
   7.4 Capacity Planning & Resource Estimation
   7.5 High Availability & Disaster Recovery Design
8. Security Design
9. Key Risks & Mitigation Measures
10. Execution Schedule & Milestones
11. Open Issues
```

> Boundary: this Skill may define deployment architecture as part of a construction or high-level design document, but it does not produce deployment runbooks, release commands, rollback execution steps, or operational change records.

**Completion criterion:** the chosen structure contains every decision-relevant section, stays at proposal or high-level depth, and gives detailed design an approved set of boundaries and decisions.

## Context and Baseline Check

Pre-execution checks:
- Whether the project has technical proposal templates or formatting requirements
- Whether Architecture Decision Record (ADR) conventions exist
- Existing tech stack constraints and selection principles
- Existing glossary or domain model; record only decisions that are hard to reverse, surprising without context, and based on a real trade-off

## Tool Selection

- Use `rd-research` when current documentation, maturity, compatibility, cost, policy, or industry evidence materially affects the recommendation
- Prefer primary sources and the narrowest configured retrieval capability
- Use Context7 or an equivalent documentation retriever only for current framework, library, SDK, or API facts
- Treat reference architectures as examples, not proof that a design fits this project's constraints

## Quality Gates

Pre-delivery checklist:

- [ ] Candidate solutions are compared when a real choice exists
- [ ] Recommendation rationale is clear, confidence level labeled
- [ ] Security dimension covered (authentication, validation, protection, auditing)
- [ ] Risks identified, each with mitigation measures
- [ ] Exit path or alternative path documented for high-impact decisions
- [ ] Key data has source attribution; inferences and facts are distinguished
- [ ] Document structure is complete; readers can understand independently
- [ ] Design remains at proposal/high-level depth and does not drift into code implementation
- [ ] Version-sensitive technology claims and configuration assumptions are verified or explicitly bounded

## Out of Scope

- Do not present a single solution claiming "this is the optimal answer"
- Do not fabricate benchmark data or performance figures
- Do not present inferences as verified facts
- Do not write code, tests, deployment runbooks, or execution procedures
- Use `rd-writing` for technical articles, white papers, research reports, or decision briefs whose primary challenge is audience-ready narrative rather than architecture selection
