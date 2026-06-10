# User Prompt Templates

> Designed for the Codex Three-Layer Delivery document workflow. Replace `{placeholders}` with actual content, then paste into Codex CLI, Codex App, Cursor, or Claude Code.
>
> Skills are matched through the `$rd-*` prefix. This template set intentionally excludes coding, code review, testing, deployment execution, and release operations.

---

## Table of Contents

1. [Requirements Analysis](#1-requirements-analysis-rd-requirement)
2. [Requirements Review](#2-requirements-review-rd-review)
3. [Research Evidence](#3-research-evidence-rd-research)
4. [Feasibility Analysis](#4-feasibility-analysis-rd-feasibility)
5. [Feasibility Review](#5-feasibility-review-rd-review)
6. [Technical Proposal / High-Level Design / Construction Plan](#6-technical-proposal--high-level-design--construction-plan-rd-solution)
7. [Proposal Review](#7-proposal-review-rd-review)
8. [Detailed Design](#8-detailed-design-rd-design)
9. [Design Review](#9-design-review-rd-review)
10. [Standards Work](#10-standards-work-rd-specification)
11. [Standards / Document Review](#11-standards--document-review-rd-review)

---

## 1. Requirements Analysis (`$rd-requirement`)

### Template A: PRD / SRS From Raw Requirements

```text
Use $rd-requirement

## Background
{Project/product/system background, 1-3 sentences}

## Raw User Requirements
{Preserve the user's original wording verbatim}

## Known Constraints
- Target users / stakeholders: {roles}
- Business process or policy constraints: {if any}
- Technical or system constraints: {if known, otherwise TBD}
- Compliance / standards constraints: {if any}
- Timeline / budget / resource constraints: {if any}

## Expected Output
Produce a PRD / SRS with priorities, assumptions, exclusions, traceability, and verifiable acceptance criteria.
```

### Template B: Supplement Existing Requirements

```text
Use $rd-requirement

Analyze the following existing requirements material and fill missing dimensions:

## Existing Material
{Paste text or reference file paths}

## Focus Areas
- {e.g., stakeholder roles are unclear}
- {e.g., non-functional requirements are missing}
- {e.g., acceptance criteria are not verifiable}
- {e.g., scope exclusions are not explicit}
```

---

## 2. Requirements Review (`$rd-review`)

```text
Use $rd-review, Requirements Review mode

## Review Target
{PRD / SRS document name, version, or file path}

## Document Content
{Paste the document or provide file path}

## Review Focus
- Completeness of P0/P1 requirements
- Verifiability of acceptance criteria
- Consistency of terms, roles, and scenarios
- Explicit assumptions, exclusions, and constraints

## Context
{Project phase, upstream decisions, known constraints}
```

---

## 3. Research Evidence (`$rd-research`)

Use this when external evidence materially affects a feasibility study, technical proposal, standards task, detailed design decision, or fact-dependent review. Skip it for small tasks where the provided source material is sufficient.

```text
Use $rd-research

## Research Goal
{Decision, document section, standard clause, technology choice, policy question, or review claim that needs evidence}

## Downstream Use
This evidence will support: {rd-feasibility / rd-solution / rd-specification / rd-design / rd-review}

## Required Source Types
- Target project documents: {files or excerpts}
- Standards / policies / regulations: {if relevant}
- Vendor / framework / protocol documentation: {if relevant}
- Academic or technical literature: {if relevant}
- Market, cost, or industry cases: {if relevant}

## Expected Output
Produce a source table with authority, date/version context, relevance, confidence, conflicts, gaps, and citation-ready notes. Do not write the final downstream document yet.
```

---

## 4. Feasibility Analysis (`$rd-feasibility`)

### Template A: Full Feasibility Study

```text
Use $rd-feasibility

## Decision Question
{What needs to be judged feasible or infeasible}

## Background and Requirements Source
{Reference PRD, meeting notes, project proposal, policy requirement, or stakeholder request}

## Options to Evaluate
- Option A: {description}
- Option B: {description}
- Baseline / maintain current state: {if applicable}

## Required Dimensions
- Necessity / value
- Technical feasibility
- Economic feasibility
- Schedule feasibility
- Operational feasibility
- Security and compliance feasibility
- Key risks and mitigation

## Known Inputs and Constraints
{Budget, schedule, staffing, existing systems, standards, procurement, policy, or data constraints}

## Expected Conclusion
Give a clear verdict: feasible / conditionally feasible / not feasible, with confidence, conditions, risks, and verification actions.
```

### Template B: Quick Feasibility Judgment

```text
Use $rd-feasibility

Evaluate whether {project / feature / solution} is feasible under these constraints:
{constraints}

Compare at least two options when a real choice exists. Separate facts, assumptions, estimates, and unknowns.
```

---

## 5. Feasibility Review (`$rd-review`)

```text
Use $rd-review, Feasibility Review mode

## Review Target
{Feasibility study / feasibility analysis report name, version, or file path}

## Document Content
{Paste the report or provide file path}

## Review Focus
- Whether the decision question and conclusion are clear
- Whether technical, economic, schedule, operational, compliance, and risk dimensions are covered
- Whether numbers and claims have sources or estimation basis
- Whether conditions, blockers, and verification actions are explicit
```

---

## 6. Technical Proposal / High-Level Design / Construction Plan (`$rd-solution`)

### Template A: Technical Proposal / High-Level Design

```text
Use $rd-solution

## Document Type
Technical Proposal / High-Level Design

## Requirements and Feasibility Inputs
- PRD / requirements: {file path or summary}
- Feasibility analysis: {file path or key conclusion, if any}

## Target Audience
{Decision-makers / client reviewers / technical leadership / implementation team}

## Known Constraints
- Technology constraints: {if any}
- Existing systems and integration boundaries: {if any}
- Performance / capacity requirements: {if any}
- Security / compliance / standards: {if any}
- Budget / schedule / staffing: {if any}

## Required Output
Compare candidate solutions, recommend one, explain rejected alternatives, and include risks, assumptions, and open issues.
```

### Template B: Construction Plan With Deployment Architecture Design

```text
Use $rd-solution

## Document Type
Construction Plan (design-level, not deployment runbook)

## Requirements Source
{Reference PRD, feasibility report, or approved proposal}

## Required Sections
- System architecture
- Deployment architecture design: topology, environment planning, capacity, HA/DR
- Security design
- Milestones and responsibilities
- Key risks and mitigation
- Open issues

## Constraints
{Infrastructure, network, security, compliance, staffing, procurement, or review constraints}
```

---

## 7. Proposal Review (`$rd-review`)

```text
Use $rd-review, Proposal Review mode

## Review Target
{Technical proposal / high-level design / construction plan name, version, or file path}

## Document Content
{Paste the document or provide file path}

## Reference Inputs
- Requirements: {PRD path or summary}
- Feasibility report: {path or summary, if any}

## Review Focus
- Requirements coverage
- Candidate solution sufficiency and fairness
- Architecture rationality
- Security, reliability, scalability, cost, and risk
- Whether deployment architecture is design-level and not operational runbook content
```

---

## 8. Detailed Design (`$rd-design`)

```text
Use $rd-design

## Design Scope
{Modules, subsystems, interfaces, data domains, or business processes covered}

## Upstream Inputs
- PRD / requirements: {file path or summary}
- Technical proposal / high-level design: {file path or key decisions}
- Standards / compliance constraints: {if any}

## Required Design Content
- Module boundaries and responsibilities
- Interface contracts
- Data model and lifecycle
- Critical flows and state machines
- Error handling and timeout paths
- Security and audit design
- Concurrency and idempotency requirements
- Open decisions with owner and deadline

## Special Focus
{e.g., cross-system integration, data consistency, audit logs, cybersecurity, standard compliance}
```

---

## 9. Design Review (`$rd-review`)

```text
Use $rd-review, Design Review mode

## Review Target
{Detailed design document name, version, or file path}

## Document Content
{Paste the design or provide file path}

## Review Focus
- Interface completeness
- Data model correctness
- Flow, state, error, timeout, and concurrency coverage
- Security and audit design
- Traceability to requirements and upstream proposal
- Unresolved items with owner and deadline
```

---

## 10. Standards Work (`$rd-specification`)

### Template A: Standards Drafting / Revision

```text
Use $rd-specification

## Standards Task
{Draft / revise / compare / perform gap analysis}

## Standard Type and Status
{National / industry / enterprise / internal specification; draft / review draft / published baseline}

## Scope
{Chapters, clauses, domain, system boundary, or technical topic}

## Source Material
- Existing draft: {file path or pasted content}
- Normative references: {list if known}
- Upstream requirements or policies: {if any}

## Required Output
Provide clause-level suggestions, normative wording, terminology checks, unresolved issues, and evidence boundaries.
```

### Template B: Clause-Level Standards Review

```text
Use $rd-specification

Review the following standard/specification clauses objectively and rigorously.

## Clauses
{Paste clauses, tables, figures, or terms}

## Review Requirements
- Quote or identify the exact clause for every issue
- Do not invent standards or unsupported evidence
- Mark insufficient evidence as "requires human verification"
- Provide replacement normative wording when possible
```

---

## 11. Standards / Document Review (`$rd-review`)

```text
Use $rd-review, Standards Review mode

## Review Target
{Standard / specification / guideline name, version, or file path}

## Document Content
{Paste target clauses or provide file path}

## Review Focus
- Scope and authority
- Normative clarity
- Clause correctness and verifiability
- Terminology and reference consistency
- Conflicts with referenced documents
- Replacement wording for major findings
```

---

## Combined Usage Example

```text
# Step 1: Requirements Analysis
Use $rd-requirement
Structure the user's original needs into a PRD with priorities, assumptions, exclusions, and acceptance criteria.

# Step 2: Requirements Review
Use $rd-review, Requirements Review mode
Review the PRD for completeness, verifiability, consistency, and boundary clarity.

# Optional: Research Evidence
Use $rd-research
Collect and validate external evidence when feasibility, solution, standards, design, or review conclusions depend on literature, standards, policy, vendor documentation, cost assumptions, maturity claims, or industry cases.

# Step 3: Feasibility Analysis
Use $rd-feasibility
Evaluate whether the project is feasible across technical, economic, schedule, operational, compliance, and risk dimensions.

# Step 4: Technical Proposal / High-Level Design
Use $rd-solution
Write a technical proposal based on the PRD and feasibility conclusion. Compare candidate solutions and recommend one.

# Step 5: Proposal Review
Use $rd-review, Proposal Review mode
Review requirements coverage, architecture rationale, risk, cost, and design-level deployment architecture.

# Step 6: Detailed Design
Use $rd-design
Produce detailed design for selected modules, including interfaces, data, flows, errors, security, and concurrency.

# Step 7: Design Review
Use $rd-review, Design Review mode
Review the detailed design for completeness, traceability, correctness, and unresolved decisions.

# Optional: Standards Work
Use $rd-specification
Draft or review standard/specification clauses with clause-level evidence and normative wording.
```

---

## Prompt Tips

| Tip | Description |
|-----|-------------|
| Preserve raw source text | Keep the user's original requirement, clause, or document text intact before structuring it |
| Specify document type | PRD, feasibility study, technical proposal, high-level design, detailed design, standard, or review report |
| Provide upstream references | Link PRD -> feasibility -> proposal -> detailed design -> review for traceability |
| Use research selectively | Invoke `$rd-research` only when external evidence materially affects the downstream document or review |
| Demand evidence separation | Ask the agent to separate facts, assumptions, estimates, inferences, and unknowns |
| State review focus | Focused reviews produce higher signal than generic "please review" prompts |
| Use standards wording constraints | For standards, require clause references, replacement wording, and "requires human verification" where evidence is missing |
| Keep execution out of scope | Do not ask these skills to write code, run tests, deploy, or operate systems |
