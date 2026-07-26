---
name: rd-requirement
description: >-
  Turn raw needs, meeting notes, stakeholder feedback, or business scenarios
  into a PRD, SRS, structured requirements, or traceability material. Use when
  scope, actors, rules, constraints, priorities, and acceptance must be made
  explicit and verifiable, including product, system, infrastructure, or AI-tool
  requirements. Do not use for feasibility conclusions, design, review, or implementation.
---

# rd-requirement

Transform raw user needs into **structured, traceable, and verifiable requirements documents**.

## Deliverables

- PRD / SRS / structured requirements document
- User role and scenario model
- Stakeholder analysis matrix (for complex or multi-party projects)
- Requirements traceability matrix (optional)

## Execution Steps

### 1. Requirements Elicitation & Clarification

- Distinguish between the user's original phrasing and structured requirements; preserve original phrasing without altering intent
- Identify implicit assumptions and list them explicitly
- Resolve discoverable facts from supplied materials and the project before asking the user
- Ask only for decisions or decision-critical ambiguity; handle one high-impact decision branch at a time, and if risk is low, state assumptions and proceed
- Identify overloaded or conflicting domain terms and propose a canonical term without inventing business meaning
- Use the 5W1H framework (Who / What / Why / When / Where / How) to ensure full dimensional coverage

### 2. Requirements Classification & Structuring

Classify and organize along the following dimensions:

| Category | Content |
|----------|---------|
| Functional Requirements (FR) | What the system must do |
| Non-Functional Requirements (NFR) | Performance, availability, scalability, security, compatibility |
| Constraints | Tech stack, platform, regulations, budget, timeline |
| Assumptions | Unconfirmed premises that affect design |
| Exclusions | Items explicitly out of scope |
| Operating context | environment, topology, user capability, support, migration, and lifecycle constraints |

For document-centered projects, also classify:

| Category | Content |
|----------|---------|
| Stakeholders | users, owners, reviewers, maintainers, external agencies |
| Business rules | policy, process, approval, compliance, or operational rules |
| Data and interfaces | required data objects, external systems, exchange boundaries |
| Evidence sources | meeting notes, standards, existing documents, laws, product decisions |

### 3. Priority Labeling

Label each requirement with a priority:

- **P0 (Must Have)**: Project fails without it
- **P1 (Should Have)**: Important, but can be deferred to next iteration
- **P2 (Nice to Have)**: Beneficial if included
- **P3 (Won't Have)**: Identified but explicitly excluded

### 4. Acceptance Criteria Definition

Attach verifiable acceptance criteria to each functional requirement:

- Use Given / When / Then when it fits the requirement
- Include normal path, exception path, boundary condition, and review/approval evidence
- For non-functional requirements, define measurable thresholds or explicit evaluation methods
- For policy or document requirements, define the review criterion and evidence needed for acceptance
- For installation, configuration, migration, or integration requirements, define the observable end state, verification method, failure behavior, and rollback expectation without prescribing an unapproved implementation

### 5. Feasibility Pre-Assessment

Perform a preliminary feasibility judgment on key requirements:

- Feasibility signal: whether the requirement appears feasible, conditionally feasible, or uncertain
- Risk flagging: identify requirements that need feasibility analysis, stakeholder confirmation, or standard/legal verification
- Dependency flagging: identify upstream decisions, external systems, approvals, and standards references

### 6. Requirements Convergence Pass

Before delivery, rewrite the structured requirements once as a lossless authoritative baseline:

- Collapse duplicated facts, rules, and scenarios into one owning section
- Remove resolved questions and temporary elicitation notes after preserving their decisions
- Preserve every requirement ID, source anchor, decision, constraint, priority, and acceptance mapping
- Re-read the document end to end and reopen any contradiction, missing acceptance method, or unresolved blocking decision

## Spec Injection Check

Pre-execution checks:
- Applicable project guidance, templates, and rules for requirements work
- Whether established product standards or quality attribute baselines exist
- Existing requirements document format and naming conventions
- Existing glossary, stakeholder map, review checklist, or standard terminology constraints

## Tool Selection

- Inspect user-provided and local project sources before external retrieval
- Use `rd-research` when laws, standards, policy, external interfaces, or other evidence materially affect a requirement
- Use only configured tools, prefer primary sources, and use library/API documentation retrieval only for current interface facts
- If retrieval is unavailable, mark the evidence gap instead of inventing a requirement

## Quality Gates

Pre-delivery checklist:

- [ ] Every identified in-scope core scenario is covered and traceable to a source or decision
- [ ] Every functional requirement has acceptance criteria
- [ ] Priorities labeled, no P0 requirements missing
- [ ] Assumptions and exclusions explicitly listed
- [ ] Every requirement has an acceptance method, or is explicitly marked as unresolved with a verification action
- [ ] Proposed products, models, vendors, tools, or configurations are separated from the underlying need unless approved as constraints
- [ ] Key terms, stakeholder roles, and business rules are consistent
- [ ] Decision-critical ambiguity is either resolved or explicitly listed
- [ ] Requirements are traceable to original user statements or cited source material
- [ ] The final convergence pass removed duplication without losing IDs, source anchors, decisions, or acceptance mappings

## Out of Scope

- Do not skip requirements clarification and jump directly into design
- Do not make technology selections during requirements analysis
- Do not approve requirements that cannot be verified
- Do not invent business rules, standards clauses, metrics, or stakeholder decisions without evidence
