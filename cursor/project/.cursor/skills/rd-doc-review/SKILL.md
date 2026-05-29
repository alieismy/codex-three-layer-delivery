---
name: rd-doc-review
description: >-
  Use when reviewing requirements documents (PRDs), technical proposals,
  architecture designs, or detailed design documents. Performs structured review
  in three modes: requirements review, proposal review, or design review. Do
  not use for code review (use rd-code-review instead).
---

# $rd-doc-review

Perform **structured reviews** of R&D documents — automatically switch review dimensions based on document type, producing graded review findings.

## Applicable Document Types

| Mode | Review Target | Upstream Skill |
|------|---------------|----------------|
| **Requirements Review** | PRD / SRS / Requirements document | `$rd-requirements-analysis` |
| **Proposal Review** | Technical proposal / High-level design / Implementation plan | `$rd-technical-writing` |
| **Design Review** | Detailed design document | `$rd-detailed-design` |

## Deliverables

- Structured review report (graded issue list + improvement recommendations)
- Review verdict (Approved / Conditionally Approved / Rejected)

---

## Common Review Framework

Shared review methodology across all document types:

### 1. Review Scope Confirmation

- Clarify the review target and its version
- Confirm review dimensions (comprehensive / focused on specific dimensions)
- Obtain relevant context (upstream documents, constraints)

### 2. Implicit Assumption Mining

- Identify **implicit assumptions** in the document
- Classify each assumption: verified / reasonable but unverified / questionable
- List questionable assumptions as risk items

### 3. Refutation First

- **Start by assuming the document has problems** — find the most likely weak points
- Then perform supportive analysis
- Conclude with a synthesized judgment and confidence level

### 4. Issue Grading

| Severity | Meaning | Requirement |
|----------|---------|-------------|
| **Blocker** | Fundamental flaw, cannot proceed as-is | Must be rewritten / redesigned |
| **Critical** | Major omission or error | Must be fixed before proceeding |
| **Major** | Significant room for improvement | Should be fixed |
| **Minor** | Suggested optimization | Optional |

### 5. Review Verdict

| Verdict | Conditions |
|---------|------------|
| **Approved** | No Blocker/Critical, Major ≤ 2 with clear remediation plans |
| **Conditionally Approved** | No Blocker, Critical issues have clear remediation plans |
| **Rejected** | Blocker exists, or too many Critical issues |

---

## Mode 1: Requirements Review

Review PRD / SRS / requirements documents produced by `$rd-requirements-analysis`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Completeness** | Are all P0 requirements covered? Are FR / NFR / constraints / assumptions / exclusions all present? |
| **Verifiability** | Does every functional requirement have executable acceptance criteria (Given/When/Then)? |
| **Consistency** | Are there contradictions between requirements? Is terminology consistent? |
| **Priority Reasonableness** | Is the P0/P1/P2 classification reasonable? Is there a "everything is P0" problem? |
| **Feasibility** | Are there obviously unimplementable or high-risk requirements left unflagged? |
| **Boundary Clarity** | Are exclusions explicit? Are interface boundaries clear? |
| **User Perspective** | Is it written from a user/business perspective rather than a technical one? |

### Common Issue Patterns

- Requirements described too vaguely ("the system should be high-performance") → demand quantification
- Missing or non-executable acceptance criteria
- Implicit non-functional requirements not made explicit
- Hidden dependencies between requirements not annotated

---

## Mode 2: Proposal Review

Review technical proposals / high-level designs / implementation plans produced by `$rd-technical-writing`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Requirements Coverage** | Are all P0/P1 requirements covered? Are any requirements missing or misinterpreted? |
| **Candidate Solution Sufficiency** | Are there ≥2 candidate solutions? Is the comparison objective and fair? |
| **Architectural Soundness** | Component decomposition, separation of concerns, coupling, communication patterns |
| **Scalability** | Horizontal/vertical scaling paths; is capacity planning reasonable? |
| **Reliability** | Single-point-of-failure analysis; disaster recovery strategy; data consistency |
| **Security** | Authentication & authorization, data protection, API security |
| **Deployment Architecture** (implementation plan) | Infrastructure topology, deployment strategy, environment planning, capacity estimation |
| **Cost** | Are development / operational / licensing cost estimates reasonable? |
| **Risk** | Is risk identification thorough? Are mitigation measures viable? |
| **Rollback** | Does an exit path exist if the solution fails? |

### Common Issue Patterns

- Only one "optimal solution" presented with no comparison
- Performance figures without source attribution (fabricated benchmarks)
- Operational complexity overlooked
- Implementation plan missing deployment architecture and environment planning

---

## Mode 3: Design Review

Review detailed design documents produced by `$rd-detailed-design`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Interface Completeness** | Are inputs / outputs / error codes / idempotency complete? Is versioning strategy clear? |
| **Data Model** | ER design soundness; field completeness; index design; normalization/denormalization rationale |
| **Flow Correctness** | Do critical flows cover happy / error / timeout paths? |
| **Concurrency Control** | Lock strategy, optimistic/pessimistic choice, race condition analysis |
| **Idempotency Design** | Do operations requiring idempotency have guarantee mechanisms? |
| **Security Design** | Authentication, authorization, input validation, data protection |
| **Error Handling** | Error classification, propagation strategy, degradation paths |
| **Implementability** | Does the design account for actual tech stack constraints and capabilities? |
| **Testability** | Does the design support unit testing and integration testing? |

### Common Issue Patterns

- Interface definitions missing error codes
- Concurrency scenarios not analyzed
- Error handling only considers "normal failures," ignoring timeouts and partial successes
- Data model denormalization without performance rationale
- Design items left as "TBD" without an owner or deadline

---

## Spec Injection Check

Pre-execution checks:
- Whether the project has review standards or checklist templates
- Existing Architecture Decision Records (ADRs)
- Previously approved documents of the same type (as baseline reference)

## MCP Tool Usage

- **DeepWiki**: Query reference architectures of similar systems
- **Sequential Thinking**: Complex trade-off reasoning and multi-solution comparison
- **Context7**: Verify technology selection feasibility
- **Tavily / Brave Search**: External verification of technical feasibility

## Quality Gates

Pre-delivery checklist:

- [ ] Correct review mode selected based on document type
- [ ] Implicit assumptions identified and classified
- [ ] Refutation analysis completed (find problems first, then strengths)
- [ ] Each issue has a severity level and specific improvement recommendation
- [ ] Review verdict is clear (Approved / Conditionally Approved / Rejected)
- [ ] Blocker/Critical issues have recommended action items

## Out of Scope

- Do not conduct "nitpicking" reviews — every finding must include a constructive recommendation
- Do not redesign during review — review is evaluation, not replacement
- Do not override well-supported decisions based on reviewer preference
- Do not just say "looks good overall" — provide a structured review
