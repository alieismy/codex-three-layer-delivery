---
name: rd-detailed-design
description: >-
  Use when producing implementation-level detailed designs including interface
  contracts, API definitions, data models, database schemas, critical flows,
  state machines, error handling, and concurrency control. Do not use for
  high-level architecture or code implementation.
---

# $rd-detailed-design

Produce **implementation-level detailed designs** based on the technical proposal — interface definitions, data models, critical flows, error handling, and concurrency control.

## Deliverables

- Detailed design document (interfaces / data models / flows / state machines)
- API contract definitions (OpenAPI / Protobuf / GraphQL Schema)
- Database schema design

## Execution Steps

### 1. Design Input Confirmation

- Confirm an existing technical proposal or high-level design (`$rd-technical-writing` output)
- Extract established: architectural decisions, tech stack selections, constraints
- Identify design scope boundaries: which modules/services are covered in this iteration

### 2. Interface Design

- Define inter-module interface contracts (inputs, outputs, error codes, idempotency requirements)
- Distinguish and label internal vs. external interfaces
- Specify API versioning strategy
- Define backward compatibility constraints for interface changes

### 3. Data Model Design

- Entity-Relationship diagram (ER Diagram) with primary keys, foreign keys, and indexes annotated
- Field-level design: type, length, constraints, defaults, nullability
- Data lifecycle: creation → update → archival → deletion
- Data consistency strategy: strong consistency / eventual consistency / compensation

### 4. Critical Flow Design

- Sequence diagrams or flowcharts for core business processes
- Each flow annotated with: happy path, error path, timeout handling
- Concurrency control strategy: lock types, optimistic/pessimistic, retry strategy
- Idempotency design: which operations must be idempotent and how to guarantee it

### 5. State Machine Design (if applicable)

- State definitions and valid transitions
- Handling strategy for invalid transitions
- Conflict resolution for concurrent state modifications

### 6. Security Design

General software security design considerations:

| Dimension | Design Content |
|-----------|----------------|
| Authentication | Authentication method selection, MFA requirements, token expiration strategy |
| Authorization | Permission model (RBAC/ABAC), principle of least privilege |
| Input Validation | Validation rules, allowlist/denylist strategy, injection prevention |
| Data Protection | Transport encryption (TLS), storage encryption, log sanitization |
| API Security | Rate limiting, signature verification, CORS policy |
| Dependency Security | Third-party library version pinning, known vulnerability checks |

### 7. Error Handling Design

- Error classification: recoverable / unrecoverable / requires human intervention
- Error code taxonomy design
- Error propagation strategy: propagate upward / handle at current layer / degrade
- Monitoring and alerting trigger conditions

## Spec Injection Check

Pre-execution checks:
- Project coding conventions and naming standards
- Existing interface design specs and API style guides
- Database design standards (naming, indexing, partitioning strategy)
- Established architectural decisions

## MCP Tool Usage

- **Context7**: Query framework/library API design best practices
- **Sequential Thinking**: Complex flow and state machine reasoning
- **DeepWiki**: Reference open-source project interface and data model designs

## Quality Gates

Pre-delivery checklist:

- [ ] Interface contracts complete (inputs / outputs / error codes / idempotency)
- [ ] Data model denormalizations beyond 3NF have documented rationale
- [ ] Critical flows cover happy / error / timeout paths
- [ ] Concurrency and idempotency requirements addressed
- [ ] Security dimensions covered (at minimum: authentication, authorization, input validation, data protection)
- [ ] Error handling strategy is explicit
- [ ] Design is traceable to requirements (each module maps to a requirement item)

## Out of Scope

- Do not skip the technical proposal and jump directly to detailed design (prompt when no upstream input exists)
- Do not leave items as "TBD" without assigning an owner and deadline
- Do not design abstraction layers that will never be used
