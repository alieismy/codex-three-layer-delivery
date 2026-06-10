---
name: rd-review
description: >-
  Use when reviewing requirements documents, PRDs, feasibility reports,
  technical proposals, high-level designs, detailed designs, standards,
  specifications, or other system-design documents. Performs structured,
  evidence-based document review with severity grading. Do not use for code
  review, testing, deployment, or implementation tasks.
---

# $rd-review

Perform **structured reviews** of requirements, feasibility, design, and standards documents, producing severity-graded findings and actionable revisions.

## Applicable Document Types

| Mode | Review Target | Upstream Skill |
|------|---------------|----------------|
| **Requirements Review** | PRD / SRS / Requirements document | `$rd-requirement` |
| **Feasibility Review** | Feasibility study / feasibility analysis report | `$rd-feasibility` |
| **Proposal Review** | Technical proposal / High-level design / construction plan | `$rd-solution` |
| **Design Review** | Detailed design document | `$rd-design` |
| **Standards Review** | Standard / specification / guideline / normative clause draft | `$rd-specification` |

## Deliverables

- Structured review report (graded issue list + improvement recommendations)
- Review verdict (Approved / Conditionally Approved / Rejected)
- Optional clause-level or section-level revision table

---

## Common Review Framework

Shared review methodology across all document types:

### 1. Review Scope Confirmation

- Clarify the review target and its version
- Confirm review dimensions (comprehensive / focused on specific dimensions)
- Obtain relevant context (upstream documents, constraints)
- Preserve the reviewed text's intent; do not silently rewrite scope or business decisions

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

Each finding should include:

- Location: section, clause, table, figure, or paragraph
- Problem: what is wrong or missing
- Evidence: source text, upstream requirement, standard, or reasoning
- Impact: why it matters
- Recommendation: concrete revision or next action

### 5. Review Verdict

| Verdict | Conditions |
|---------|------------|
| **Approved** | No Blocker/Critical, Major ≤ 2 with clear remediation plans |
| **Conditionally Approved** | No Blocker, Critical issues have clear remediation plans |
| **Rejected** | Blocker exists, or too many Critical issues |

---

## Mode 1: Requirements Review

Review PRD / SRS / requirements documents produced by `$rd-requirement`.

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

## Mode 2: Feasibility Review

Review feasibility studies or feasibility analysis reports produced by `$rd-feasibility`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Decision Clarity** | Is the feasibility question explicit? Is the verdict clear? |
| **Evidence Quality** | Are facts, estimates, assumptions, and unknowns separated? |
| **Dimension Coverage** | Are technical, economic, schedule, operational, compliance, and risk dimensions covered? |
| **Option Comparison** | Are viable alternatives compared, including current-state baseline when relevant? |
| **Cost and Schedule Basis** | Are numbers sourced, estimated transparently, or marked as assumptions? |
| **Risk Handling** | Are blockers, conditions, mitigation actions, and verification steps explicit? |
| **Conclusion Discipline** | Does the conclusion follow from the analysis rather than preference? |

### Common Issue Patterns

- "Feasible" conclusion without conditions or evidence
- Cost or schedule numbers with no source or estimation basis
- Ignoring current-state baseline
- Risks listed but not tied to mitigation or verification actions

---

## Mode 3: Proposal Review

Review technical proposals / high-level designs / construction plans produced by `$rd-solution`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Requirements Coverage** | Are all P0/P1 requirements covered? Are any requirements missing or misinterpreted? |
| **Candidate Solution Sufficiency** | Are there ≥2 candidate solutions? Is the comparison objective and fair? |
| **Architectural Soundness** | Component decomposition, separation of concerns, coupling, communication patterns |
| **Scalability** | Horizontal/vertical scaling paths; is capacity planning reasonable? |
| **Reliability** | Single-point-of-failure analysis; disaster recovery strategy; data consistency |
| **Security** | Authentication & authorization, data protection, API security |
| **Deployment Architecture** (construction plan) | Infrastructure topology, deployment strategy at design level, environment planning, capacity estimation |
| **Cost** | Are development / operational / licensing cost estimates reasonable? |
| **Risk** | Is risk identification thorough? Are mitigation measures viable? |
| **Exit Path** | Does an alternative path exist if the solution fails validation or is rejected? |

### Common Issue Patterns

- Only one "optimal solution" presented with no comparison
- Performance figures without source attribution (fabricated benchmarks)
- Operational complexity overlooked
- Construction plan missing deployment architecture and environment planning

---

## Mode 4: Design Review

Review detailed design documents produced by `$rd-design`.

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
| **Verifiability** | Can reviewers verify the design against requirements, constraints, and standards? |

### Common Issue Patterns

- Interface definitions missing error codes
- Concurrency scenarios not analyzed
- Error handling only considers "normal failures," ignoring timeouts and partial successes
- Data model denormalization without performance rationale
- Design items left as "TBD" without an owner or deadline

---

## Mode 5: Standards Review

Review standards, specifications, guidelines, or normative clause drafts produced or revised with `$rd-specification`.

### Review Dimensions

| Dimension | Checkpoints |
|-----------|-------------|
| **Authority and Scope** | Is the document type, scope, and authority clear? |
| **Clause Correctness** | Are clauses technically correct and aligned with referenced documents? |
| **Normative Clarity** | Are mandatory, recommended, and informative statements clearly separated? |
| **Verifiability** | Are requirements inspectable, testable, or auditable? |
| **Terminology Consistency** | Are terms, abbreviations, symbols, tables, and figures consistent? |
| **Reference Integrity** | Are normative references accurate, current when required, and actually used? |
| **Conflict Detection** | Are internal contradictions or conflicts with upstream standards identified? |

### Common Issue Patterns

- Vague mandatory clauses using "support", "optimize", or "improve" without criteria
- Citing standards without verifying title, status, clause, or applicability
- Mixing informative background with enforceable requirements
- Proposing implementation details that exceed the intended standard scope

---

## Spec Injection Check

Pre-execution checks:
- Whether the project has review standards or checklist templates
- Existing Architecture Decision Records (ADRs)
- Previously approved documents of the same type (as baseline reference)
- For standards: glossary, normative reference list, clause numbering, and comment-table format

## MCP Tool Usage

- **DeepWiki**: Query reference architectures of similar systems
- **Sequential Thinking**: Complex trade-off reasoning and multi-solution comparison
- **Context7**: Verify technology selection feasibility
- **web_search / Tavily / Brave Search**: External verification of standards, policies, market facts, or technical feasibility

## Quality Gates

Pre-delivery checklist:

- [ ] Correct review mode selected based on document type
- [ ] Implicit assumptions identified and classified
- [ ] Refutation analysis completed (find problems first, then strengths)
- [ ] Each issue has a severity level and specific improvement recommendation
- [ ] Review verdict is clear (Approved / Conditionally Approved / Rejected)
- [ ] Blocker/Critical issues have recommended action items
- [ ] Standards or external claims are either cited, verified, or explicitly marked as requiring human verification

## Out of Scope

- Do not conduct "nitpicking" reviews — every finding must include a constructive recommendation
- Do not redesign during review — review is evaluation, not replacement
- Do not override well-supported decisions based on reviewer preference
- Do not just say "looks good overall" — provide a structured review
- Do not fabricate standards clauses, source evidence, or document status
