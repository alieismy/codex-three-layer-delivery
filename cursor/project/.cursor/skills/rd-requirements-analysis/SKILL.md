---
name: rd-requirements-analysis
description: >-
  Use when analyzing user needs, structuring requirements, writing PRDs, SRS
  documents, or user stories. Use when raw requirements, meeting notes, or
  feature requests need to be structured and prioritized. Do not use for
  technical design or code implementation.
---

# $rd-requirements-analysis

Transform vague user needs into **structured, verifiable requirements documents**.

## Deliverables

- Structured requirements document (PRD / SRS / User Story collection)
- Stakeholder analysis matrix (for complex projects)
- Requirements traceability matrix (optional)

## Execution Steps

### 1. Requirements Elicitation & Clarification

- Distinguish between the user's original phrasing and structured requirements; preserve original phrasing without altering intent
- Identify implicit assumptions and list them explicitly
- Ask targeted questions for each ambiguous point — do not guess or fill in gaps
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

### 3. Priority Labeling

Label each requirement with a priority:

- **P0 (Must Have)**: Project fails without it
- **P1 (Should Have)**: Important, but can be deferred to next iteration
- **P2 (Nice to Have)**: Beneficial if included
- **P3 (Won't Have)**: Identified but explicitly excluded

### 4. Acceptance Criteria Definition

Attach verifiable acceptance criteria to each functional requirement:
- Given / When / Then format
- Cover happy path, error path, and boundary conditions

### 5. Feasibility Pre-Assessment

Perform a preliminary feasibility judgment on key requirements:
- Technical feasibility: whether existing solutions exist or custom development is needed
- Risk flagging: flag high-risk requirements and recommend prototype validation

## Spec Injection Check

Pre-execution checks:
- Whether project AGENTS.md specifies requirements template conventions
- Whether established product standards or quality attribute baselines exist
- Existing requirements document format and naming conventions

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
- [ ] Understanding confirmed with user — no deviation

## Out of Scope

- Do not skip requirements clarification and jump directly into design
- Do not make technology selections during requirements analysis
- Do not approve requirements that cannot be verified
