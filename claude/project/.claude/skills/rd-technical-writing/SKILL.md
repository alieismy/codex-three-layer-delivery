---
name: rd-technical-writing
description: >-
  Use when writing technical proposals, high-level designs, solution
  architecture documents, feasibility analyses, or implementation plans. Use
  when comparing candidate solutions or creating construction plans with
  deployment architecture. Do not use for detailed design or code
  implementation.
---

# $rd-technical-writing

Research and produce high-quality technical documents — **technical proposals, high-level designs, implementation plans, feasibility analyses, and technical white papers**.

## Deliverables

- Technical proposal / High-level design / Implementation plan
- Candidate solution comparison matrix
- Recommended solution with risk statement

## Execution Steps

### 1. Objective & Constraint Confirmation

- Clarify the document type (high-level design / implementation plan / feasibility analysis)
- Confirm the audience (decision-makers / technical team / client reviewers)
- Confirm constraints: timeline, budget, tech stack, compliance requirements
- Check for existing requirements documents (`$rd-requirements-analysis` output)

### 2. Solution Research & Candidate Generation

- Generate at least **2 candidate solutions** — presenting a single "optimal solution" is not allowed
- Each solution must include: architecture overview, core components, tech stack, deployment topology
- Use search tools to verify the feasibility and maturity of key technology selections

### 3. Multi-Dimensional Cross-Check

Evaluate each candidate solution across the following dimensions:

| Dimension | Check Content |
|-----------|---------------|
| Functional completeness | Does it cover all P0/P1 requirements? |
| Performance | Capacity planning, bottleneck prediction, scaling path |
| Reliability | Fault tolerance, disaster recovery, data consistency strategy |
| Security | Authentication & authorization, input validation, data protection, auditing |
| Maintainability | Code organization, monitoring & alerting, operational complexity |
| Cost | Development cost, operational cost, licensing fees |
| Risk | Technical risk, staffing risk, schedule risk, external dependency risk |
| Rollback | Exit path if the solution fails |

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
9. Execution Schedule (milestones)
10. Open Issues
```

#### Implementation Plan (with Deployment Architecture)

```
1. Background & Objectives
2. Requirements Summary
3. Constraints
4. Candidate Solutions & Comparison
5. Recommended Solution
6. System Architecture Design
7. Deployment Architecture Design
   7.1 Infrastructure Topology (network, compute, storage)
   7.2 Environment Planning (development / testing / staging / production)
   7.3 Deployment Strategy (rolling / blue-green / canary)
   7.4 Capacity Planning & Resource Estimation
   7.5 High Availability & Disaster Recovery Design
8. Security Design
9. Key Risks & Mitigation Measures
10. Execution Schedule & Milestones
11. Open Issues
```

> **Boundary with `$rd-deployment`**: The implementation plan defines the deployment *design* (topology, strategy, environment planning); `$rd-deployment` handles deployment *execution* (runbook, scripts, rollback verification, change records).

## Spec Injection Check

Pre-execution checks:
- Whether the project has technical proposal templates or formatting requirements
- Whether Architecture Decision Record (ADR) conventions exist
- Existing tech stack constraints and selection principles

## MCP Tool Usage

- **Context7**: Query tech stack/framework official documentation and best practices
- **DeepWiki**: Analyze reference project architectures
- **Sequential Thinking**: Complex multi-solution comparative reasoning
- **Tavily / Brave Search**: Technology selection feasibility verification, industry case studies
- **web_search** (Codex built-in): Quick verification of version numbers, compatibility

## Quality Gates

Pre-delivery checklist:

- [ ] Candidate solutions ≥ 2, comparison is thorough
- [ ] Recommendation rationale is clear, confidence level labeled
- [ ] Security dimension covered (authentication, validation, protection, auditing)
- [ ] Risks identified, each with mitigation measures
- [ ] Rollback / exit path documented
- [ ] Key data has source attribution; inferences and facts are distinguished
- [ ] Document structure is complete; readers can understand independently

## Out of Scope

- Do not present a single solution claiming "this is the optimal answer"
- Do not fabricate benchmark data or performance figures
- Do not present inferences as verified facts
