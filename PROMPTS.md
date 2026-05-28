# v4 User Prompt Templates

> Designed for use with the Codex Three-Layer Delivery System v4. Replace `{placeholders}` with your actual content, then paste directly into Codex CLI or Codex App.
>
> **How to use**: Copy a template, fill in the `{placeholders}`, and submit. Skills are automatically matched via the `$rd-*` prefix.

---

## Table of Contents

1. [Requirements Analysis](#1-requirements-analysis-rd-requirements-analysis)
2. [Requirements Review](#2-requirements-review-rd-doc-review-requirements-review-mode)
3. [Technical Proposal / High-Level Design](#3-technical-proposal--high-level-design-rd-technical-writing)
4. [Implementation Plan](#4-implementation-plan-rd-technical-writing)
5. [Proposal Review](#5-proposal-review-rd-doc-review-proposal-review-mode)
6. [Detailed Design](#6-detailed-design-rd-detailed-design)
7. [Design Review](#7-design-review-rd-doc-review-design-review-mode)
8. [Code Implementation](#8-code-implementation-rd-implement)
9. [Code Review](#9-code-review-rd-code-review)
10. [Testing](#10-testing-rd-testing)
11. [Deployment](#11-deployment-rd-deployment)

---

## 1. Requirements Analysis (`$rd-requirements-analysis`)

### Template A: Greenfield Requirements Analysis

```
Use $rd-requirements-analysis

## Background
{Project/product background, 1-3 sentences}

## Raw User Requirements
{User's original description — preserve verbatim, do not modify}

## Known Constraints
- Tech stack: {e.g., Java/Spring Boot, Python/FastAPI, React, or "TBD"}
- Target users: {e.g., B2B operations staff, B2C consumers}
- Timeline: {e.g., Q3 delivery, 2 months}
- Budget/resource constraints: {if any}

## Expected Output
{PRD / SRS / User Story collection — pick one or more}
```

### Template B: Supplement Existing Requirements

```
Use $rd-requirements-analysis

Perform a structured analysis on the following existing requirements material.
Fill in missing dimensions (non-functional requirements, constraints, assumptions, exclusions, acceptance criteria):

## Existing Material
{Paste or reference existing requirements descriptions / meeting notes / user feedback}

## Areas of Focus
- {e.g., Performance requirements are unclear}
- {e.g., Boundary scenarios are undefined}
- {e.g., Third-party integration scope is ambiguous}
```

### Template C: Quick Version (Clear Instruction)

```
Use $rd-requirements-analysis to structure the following requirements into a PRD with priorities and acceptance criteria:

{Paste raw user requirements here}
```

---

## 2. Requirements Review (`$rd-doc-review` Requirements Review mode)

### Template

```
Use $rd-doc-review, Requirements Review mode

## Review Target
{PRD/SRS document name or version}

## Document Content
{Paste full PRD, or specify file path}

## Review Focus (optional)
- {e.g., Focus on P0 requirement completeness}
- {e.g., Check for contradictions between requirements}
- {e.g., Are acceptance criteria executable?}

## Context
- Project phase: {e.g., Project kickoff review, iteration planning}
- Known constraints: {e.g., Must be compatible with existing system X}
```

---

## 3. Technical Proposal / High-Level Design (`$rd-technical-writing`)

### Template A: Technical Proposal

```
Use $rd-technical-writing

## Document Type
Technical Proposal / High-Level Design

## Requirements Source
{Reference PRD file path or key requirements summary}

## Target Audience
{Decision-makers / Technical team / Client reviewers}

## Known Constraints
- Tech stack: {e.g., Must use Java 17+, PostgreSQL}
- Deployment environment: {e.g., K8s cluster, on-premise}
- Performance requirements: {e.g., P99 < 200ms, 100K DAU}
- Security/compliance: {e.g., SOC 2, GDPR, HIPAA}
- Budget: {e.g., Annual cloud budget $50K}

## Special Considerations
- {e.g., Must integrate with existing system X}
- {e.g., Data migration strategy needed}
- {e.g., Compare microservices vs. monolithic architecture}
```

### Template B: Feasibility Analysis

```
Use $rd-technical-writing

## Document Type
Feasibility Analysis

## Analysis Objective
{One sentence describing what feasibility to evaluate}

## Requirements Source
{Reference PRD or directional requirements from business stakeholders}

## Dimensions to Evaluate
- Technical feasibility: {e.g., Can the existing tech stack support this? Does it require new technology?}
- Cost feasibility: {e.g., Development timeline, operational costs, licensing fees}
- Risk assessment: {e.g., Team skill fit, external dependency stability}

## Known Constraints
- {e.g., Must extend existing architecture — greenfield rebuild not permitted}
- {e.g., Team has no Rust experience}
- {e.g., Budget cap $30K}

## Expected Conclusion
Provide a clear verdict: Feasible / Conditionally Feasible / Not Feasible, with rationale and confidence level.
```

### Template C: Quick Version

```
Use $rd-technical-writing to write a technical proposal.

Requirements: {One-sentence core requirement}
Constraints: Tech stack {X}, deployed on {Y}, performance target {Z}.
Provide at least 2 candidate solutions with comparison.
```

---

## 4. Implementation Plan (`$rd-technical-writing`)

### Template

```
Use $rd-technical-writing

## Document Type
Implementation Plan (with Deployment Architecture)

## Requirements Source
{Reference PRD or high-level design document}

## Target Audience
{Technical team + Operations / Client}

## Known Constraints
- Infrastructure: {e.g., AWS / Azure / GCP / On-premise data center}
- Network topology: {e.g., Multi-AZ, dedicated link}
- Availability requirements: {e.g., 99.99% SLA}
- Data volume estimate: {e.g., 100GB/day ingestion, 10TB total}
- Operations team size: {e.g., 3 engineers}

## Key Requirements
- Deployment architecture must include: infrastructure topology, environment planning, deployment strategy, capacity planning, HA design
- {Any additional special requirements}
```

---

## 5. Proposal Review (`$rd-doc-review` Proposal Review mode)

### Template

```
Use $rd-doc-review, Proposal Review mode

## Review Target
{Technical proposal / High-level design / Implementation plan — document name or version}

## Document Content
{Paste full proposal, or specify file path}

## Review Focus (optional)
- {e.g., Is the candidate solution comparison thorough and objective?}
- {e.g., Does the deployment architecture meet HA requirements?}
- {e.g., Are cost estimates reasonable?}
- {e.g., Integration risk with existing systems}

## Reference Requirements
{Reference the corresponding PRD to check requirements coverage}
```

---

## 6. Detailed Design (`$rd-detailed-design`)

### Template A: Full Detailed Design

```
Use $rd-detailed-design

## Design Scope
{Modules/services covered in this design iteration}

## Upstream Input
- Technical proposal: {Reference document path or key architectural decisions}
- Confirmed tech stack: {e.g., Spring Boot 3.x + PostgreSQL 16 + Redis 7}
- Architectural constraints: {e.g., Microservices, event-driven}

## Design Deliverables Needed
- [ ] Interface design (API contracts)
- [ ] Data model design (ER diagram + schema)
- [ ] Critical flow design (sequence/flow diagrams)
- [ ] State machine design (if applicable)
- [ ] Security design
- [ ] Error handling design

## Areas of Focus
- {e.g., Concurrency control for order state transitions}
- {e.g., Idempotency for payment system integration}
- {e.g., Encryption strategy for user PII data}
```

### Template B: Single-Module Design

```
Use $rd-detailed-design

Produce a detailed design for the {module name} module.

Upstream decisions: {Summarize confirmed architectural decisions}
Tech stack: {X}
Core entities: {e.g., User, Order, Product}
Critical flows: {e.g., Order placement, refund processing}
Concurrency requirements: {e.g., Must support flash-sale scenarios}
```

---

## 7. Design Review (`$rd-doc-review` Design Review mode)

### Template

```
Use $rd-doc-review, Design Review mode

## Review Target
{Detailed design document name or version}

## Document Content
{Paste full detailed design, or specify file path}

## Review Focus (optional)
- {e.g., Are interface contracts complete (inputs/outputs/error codes/idempotency)?}
- {e.g., Are concurrency scenarios sufficiently analyzed?}
- {e.g., Does data model denormalization have performance justification?}
- {e.g., Is the design testable?}

## Implementation Constraints
- Tech stack: {e.g., Java 17 / Spring Boot 3.x}
- Target performance: {e.g., Single API P99 < 100ms}
```

---

## 8. Code Implementation (`$rd-implement`)

### Template A: Design-Based Implementation

```
Use $rd-implement

## Task
{One-sentence description of what to implement}

## Design Reference
{Reference detailed design document path or key design decisions}

## Implementation Scope
- {File/module 1}: {What to do}
- {File/module 2}: {What to do}

## Tech Stack
{e.g., Python 3.12 + FastAPI + SQLAlchemy + PostgreSQL}

## Acceptance Criteria
- {e.g., POST /api/orders creates an order and returns 201}
- {e.g., Invalid input returns 400 + structured error body}
- {e.g., No overselling under concurrent orders}
```

### Template B: Bug Fix

```
Use $rd-implement

## Bug Description
{Observed symptom}

## Reproduction Steps
1. {Step 1}
2. {Step 2}
3. {Expected behavior vs. actual behavior}

## Related Files
- {File path 1}
- {File path 2}

## Requirements
Write a reproduction test first, then fix, ensure the test passes.
```

### Template C: Refactoring

```
Use $rd-implement

## Refactoring Goal
{e.g., Extract order logic from UserService into a dedicated OrderService}

## Refactoring Scope
- {File path 1}
- {File path 2}

## Constraints
- All existing tests must pass before and after
- No changes to external interface behavior
- {Additional constraints}
```

### Template D: Add Feature to Existing Codebase

```
Use $rd-implement

## Task
Add {feature description} to the existing project.

## Existing Codebase Context
- Project structure: {Summarize key directories, e.g., src/services/, src/models/}
- Related existing modules: {e.g., UserService, OrderRepository}
- Existing patterns/conventions: {e.g., All returns use Result<T>, error codes defined in errors.ts}

## Design Reference
{Reference detailed design document path, or summarize key design points for the new feature}

## Implementation Requirements
- Reuse existing patterns and infrastructure — do not introduce new abstractions
- Files to modify: {List estimated file paths}

## Acceptance Criteria
- {Specific verifiable behavior 1}
- {Specific verifiable behavior 2}
```

### Template E: Quick Version (Simple Task)

```
Use $rd-implement

Implement {feature description} in {file path}.
Tech stack: {X}.
Acceptance criteria: {A specific, testable behavior}.
```

---

## 9. Code Review (`$rd-code-review`)

### Template A: PR / Changeset Review

```
Use $rd-code-review

## Review Scope
{PR link / branch name / list of changed files}

## Change Description
{Purpose and summary of this change}

## Design Reference
{Reference related detailed design document, if any}

## Review Focus (optional)
- {e.g., Focus on concurrency safety}
- {e.g., Check input validation thoroughness}
- {e.g., Assess performance impact}
```

### Template B: Quick Version

```
Use $rd-code-review

Review the following code changes:

{Paste diff or specify file paths}

Focus on: {correctness / security / performance / maintainability}
```

---

## 10. Testing (`$rd-testing`)

### Template A: Full Test Design

```
Use $rd-testing

## Test Subject
{Module/service/feature name}

## Related Documents
- Requirements: {PRD path}
- Detailed design: {Design document path}

## Test Scope
- [ ] Unit tests
- [ ] Integration tests
- [ ] System / E2E tests
- [ ] Performance tests (if needed)

## Tech Stack
- Test framework: {e.g., pytest / JUnit 5 / Jest}
- Mocking tools: {e.g., Mockito / unittest.mock}

## Key Scenarios
- {e.g., Idempotency of payment callbacks}
- {e.g., Inventory deduction under high concurrency}
- {e.g., Time calculations across timezones}
```

### Template B: Add Tests to Existing Code

```
Use $rd-testing

Write unit tests for {class/function name} in {file path}.

Test framework: {e.g., pytest}
Focus: Happy path + boundary conditions + exception inputs.
```

### Template C: System / E2E Testing

```
Use $rd-testing

## Test Type
System Test / E2E

## System Under Test
{System name and access method}

## Test Scenarios
1. {Core business flow 1}
2. {Core business flow 2}
3. {Error/degradation scenario}

## Acceptance Criteria Source
{Reference acceptance criteria from the PRD}
```

---

## 11. Deployment (`$rd-deployment`)

### Template A: Full Deployment Plan

```
Use $rd-deployment

## Deployment Content
- Code version: {e.g., v2.3.0 / commit hash}
- Configuration changes: {e.g., New env var X, modified connection pool size}
- Database changes: {e.g., New table `orders`, added index}
- Infrastructure changes: {e.g., None / Scale up 2 nodes}

## Target Environment
{Development / Testing / Staging / Production}

## Implementation Plan Reference
{Reference deployment architecture design from the implementation plan}

## Deployment Window
{e.g., Thursday 10:00-12:00 PM UTC}

## Special Considerations
- {e.g., Data migration script must run first}
- {e.g., Dependent service X must be upgraded to v3.0 first}
- {e.g., First-time deployment — database initialization required}
```

### Template B: Quick Version (Routine Release)

```
Use $rd-deployment

Deploy {service name} {version} to {environment}.
Changes: {One-sentence summary}.
Database changes: {yes/no}.
Generate a deployment runbook and rollback plan.
```

---

## Combined Usage Example

### Example: Full Requirements-to-Production Flow

> **Note**: Each step should ideally run in its own Codex session/conversation. The output of each step serves as the input reference for the next.
> For small features, multiple steps can be chained in a single session.

```
# Step 1: Requirements Analysis (new session)
Use $rd-requirements-analysis
Background: Company needs an internal ticketing system to replace the current email-based approval workflow.
Raw requirements: (paste verbatim)
Constraints: Java/Spring Boot, deployed on company K8s cluster, 2-month delivery.

# Step 2: Requirements Review (new session)
Use $rd-doc-review, Requirements Review mode
Review the PRD from Step 1. Focus on acceptance criteria and priority validation.

# Step 3: Technical Proposal
Use $rd-technical-writing
Write a technical proposal based on the PRD. Tech stack: Java 17 + Spring Boot 3.x + PostgreSQL.
Compare monolithic vs. microservices architecture.

# Step 4: Proposal Review
Use $rd-doc-review, Proposal Review mode
Review the technical proposal. Focus on architecture selection and risk assessment.

# Step 5: Detailed Design
Use $rd-detailed-design
Design the ticketing module based on the technical proposal. Include interfaces, data model, and state machine.

# Step 6: Design Review
Use $rd-doc-review, Design Review mode
Review the detailed design. Focus on idempotency and concurrency control.

# Step 7: Code Implementation
Use $rd-implement
Implement ticket CRUD + state transitions based on the detailed design.
Acceptance criteria: POST create ticket → approve → complete, full flow works end-to-end.

# Step 8: Code Review
Use $rd-code-review
Review the implementation code. Focus on security and error handling.

# Step 9: Testing
Use $rd-testing
Write unit and integration tests for the ticketing module. Cover all state machine transitions.

# Step 10: Deployment
Use $rd-deployment
Deploy ticketing system v1.0 to testing environment, including database initialization.
```

---

## Prompt Tips

| Tip | Description |
|-----|-------------|
| **Use quick templates for clear tasks** | When the task is simple and unambiguous, use the one-liner template — AI enters fast mode |
| **Use full templates for complex tasks** | Multiple constraints, multiple modules, or legacy considerations — provide full context |
| **Specify review focus** | The "Review Focus" field guides AI to prioritize key dimensions instead of generic feedback |
| **Reference upstream documents** | Use file paths to reference upstream outputs (PRD → Proposal → Design) to maintain traceability |
| **Make acceptance criteria specific** | "It works" is weaker than "POST /api/orders returns 201 + order ID" — more specific = more accurate AI |
| **Step-by-step vs. single session** | For complex projects, execute each Skill in its own session; for small features, chain multiple Skills in one session |
| **Trigger deep analysis** | Add "detailed analysis" or "in-depth evaluation" to your prompt to trigger the AI's deep mode for multi-dimensional analysis |
| **Describe context for existing codebases** | When modifying existing projects, summarize project structure and established patterns so AI reuses rather than reinvents |
