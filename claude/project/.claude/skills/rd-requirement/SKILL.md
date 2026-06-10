---
name: rd-requirement
description: >-
  Use when analyzing user needs, structuring requirements, writing PRDs, SRS
  documents, or requirement traceability materials. Use when raw user
  statements, meeting notes, stakeholder feedback, or business scenarios need
  to be structured, prioritized, and made verifiable. Do not use for solution
  design, feasibility studies, detailed design, or code implementation.
---

# $rd-requirement

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
- Ask targeted questions for decision-critical ambiguity; if risk is low, state assumptions and proceed
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

### 5. Feasibility Pre-Assessment

Perform a preliminary feasibility judgment on key requirements:

- Feasibility signal: whether the requirement appears feasible, conditionally feasible, or uncertain
- Risk flagging: identify requirements that need feasibility analysis, stakeholder confirmation, or standard/legal verification
- Dependency flagging: identify upstream decisions, external systems, approvals, and standards references

## Spec Injection Check

Pre-execution checks:
- Whether project AGENTS.md specifies requirements template conventions
- Whether established product standards or quality attribute baselines exist
- Existing requirements document format and naming conventions
- Existing glossary, stakeholder map, review checklist, or standard terminology constraints

## MCP Tool Usage

- **Context7**: Query similar product requirement patterns and best practices
- **Sequential Thinking**: Complex requirement decomposition and dependency analysis
- **DeepWiki**: Reference how open-source projects organize requirements

## Quality Gates

Pre-delivery checklist:

- [ ] 100% coverage of core scenarios
- [ ] Every functional requirement has acceptance criteria
- [ ] Priorities labeled, no P0 requirements missing
- [ ] Assumptions and exclusions explicitly listed
- [ ] All requirements are verifiable (no untestable requirements exist)
- [ ] Key terms, stakeholder roles, and business rules are consistent
- [ ] Decision-critical ambiguity is either resolved or explicitly listed
- [ ] Requirements are traceable to original user statements or cited source material

## Out of Scope

- Do not skip requirements clarification and jump directly into design
- Do not make technology selections during requirements analysis
- Do not approve requirements that cannot be verified
- Do not invent business rules, standards clauses, metrics, or stakeholder decisions without evidence
