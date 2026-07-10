---
name: rd-solution
description: >-
  Use when converting approved requirements or feasibility inputs into a
  technical proposal, high-level design, solution architecture, outline design,
  construction plan, or technical white paper. Apply when real alternatives,
  architectural decisions, and a design-ready recommendation are needed. Do not
  use for feasibility conclusions, detailed design, independent review, or execution.
---

# rd-solution

Research and produce high-quality technical documents — **technical proposals, high-level designs, solution architecture documents, construction plans, and technical white papers**.

## Deliverables

- Technical proposal / High-level design / Solution architecture document
- Construction plan or design-oriented project plan
- Candidate solution comparison matrix
- Recommended solution with risk statement

## Execution Steps

### 1. Objective & Constraint Confirmation

- Clarify the document type (technical proposal / high-level design / solution architecture / construction plan)
- Confirm the audience (decision-makers / technical team / client reviewers)
- Confirm constraints: timeline, budget, tech stack, compliance requirements
- Check for existing requirements documents (`rd-requirement` output)
- Check for feasibility inputs (`rd-feasibility` output) when the project has an approval phase
- Resolve discoverable facts from project artifacts; ask the user only for material decisions that remain open
- Use established domain terminology and surface conflicts instead of silently creating synonyms

### 2. Solution Research & Candidate Generation

- Generate at least **2 candidate solutions** when a real architectural or technical choice exists
- Each solution should include: architecture overview, core components, data/interface boundaries, technology choices, deployment or operating assumptions
- Use search tools to verify the feasibility and maturity of key technology selections

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

### 4. Recommendation & Decision Guidance

- Provide recommendations based on quantitative or semi-quantitative comparison
- Clearly state the rationale for the recommendation and the reasons for rejecting alternatives
- Label the recommendation confidence level (High / Medium / Low) with supporting basis
- State residual risks and items requiring further confirmation

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

## Spec Injection Check

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

## Out of Scope

- Do not present a single solution claiming "this is the optimal answer"
- Do not fabricate benchmark data or performance figures
- Do not present inferences as verified facts
- Do not write code, tests, deployment runbooks, or execution procedures
