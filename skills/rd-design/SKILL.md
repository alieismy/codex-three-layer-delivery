---
name: rd-design
description: >-
  Produce an implementation-ready detailed design from approved requirements
  and architecture decisions. Use when interface contracts, schemas, critical
  flows, state machines, configuration contracts, trust boundaries, errors,
  security, observability, concurrency, or recovery behavior must be specified
  for software or infrastructure. Do not use for requirements, option selection,
  review, implementation, or operational execution.
---

# rd-design

Produce **construction-ready detailed designs** based on approved requirements and technical proposals — interface definitions, data models, critical flows, error handling, security design, and concurrency control.

## Deliverables

- Detailed design document (interfaces / data models / flows / state machines)
- API contract definitions (OpenAPI / Protobuf / GraphQL Schema)
- Database schema design
- Security, error handling, and observability design sections
- Configuration, migration, verification, and rollback contracts when infrastructure or integration is in scope

## Execution Steps

### 1. Design Input Confirmation

- Confirm the approved requirements and any material technical proposal or high-level design (`rd-solution` output)
- Extract established: architectural decisions, tech stack selections, constraints
- Identify design scope boundaries: which modules/services are covered in this iteration
- Confirm traceability to PRD items or stakeholder-approved design decisions

### 2. Interface Design

- Define inter-module interface contracts (inputs, outputs, invariants, preconditions, postconditions, error codes, ordering, and idempotency requirements)
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
| Trust Boundaries | actors, zones, data flows, threat assumptions, and abuse cases |
| Input Validation | Validation rules, allowlist/denylist strategy, injection prevention |
| Data Protection | classification, minimization, transport/storage encryption, retention, and log sanitization |
| API Security | Rate limiting, signature verification, CORS policy |
| Secrets | credential ownership, storage, rotation, revocation, and exposure handling |
| Auditability | audit events, traceability, log retention, sensitive-field masking |

### 7. Error Handling Design

- Error classification: recoverable / unrecoverable / requires human intervention
- Error code taxonomy design
- Error propagation strategy: propagate upward / handle at current layer / degrade
- Monitoring and alerting trigger conditions

### 8. Configuration and Change Design (if applicable)

- Define configuration ownership, source of truth, schema, defaults, validation rules, environment variance, and precedence
- Separate secrets from ordinary configuration and define provisioning, rotation, revocation, and redaction boundaries
- Define migration stages, compatibility window, rollback conditions, recovery point, and state reconciliation
- Specify expected observations and verification criteria without turning the design into an execution runbook

### 9. Design Verification Notes

- Define how reviewers can verify the design: traceability matrix, checklist, walkthrough, prototype, or external standard check
- Mark unresolved design items with decision dependency, verification action, and owner or target date when known; otherwise mark them unassigned or unconfirmed
- Identify assumptions that must be validated before implementation starts

## Spec Injection Check

Pre-execution checks:
- Project design conventions and naming standards
- Existing interface design specs and API style guides
- Database design standards (naming, indexing, partitioning strategy)
- Established architectural decisions
- Security, privacy, compliance, or standards requirements that constrain design

## Tool Selection

- Inspect approved requirements, architecture decisions, schemas, and local conventions first
- Use `rd-research` when external standards or current technology facts materially constrain the design
- Use Context7 or an equivalent documentation retriever only for current framework, library, SDK, or API behavior
- Treat external repository designs as examples and verify applicability against this system's constraints

## Quality Gates

Pre-delivery checklist:

- [ ] Interface contracts complete (inputs / outputs / error codes / idempotency)
- [ ] Data model normalization or denormalization choices have documented rationale
- [ ] Critical flows cover happy / error / timeout paths
- [ ] Concurrency and idempotency requirements addressed
- [ ] Security dimensions covered (at minimum: authentication, authorization, input validation, data protection)
- [ ] Error handling strategy is explicit
- [ ] Configuration, migration, recovery, and rollback contracts are explicit when applicable
- [ ] Design is traceable to requirements (each module maps to a requirement item)
- [ ] Unresolved design decisions have owner, deadline, and dependency
- [ ] The document gives reviewers enough detail to assess feasibility and consistency

## Out of Scope

- Do not proceed when missing upstream decisions would make the design speculative; approved requirements may be sufficient when no material architecture choice remains open
- Do not leave items as "TBD" without a verification action and an explicit assignment state
- Do not design abstraction layers that will never be used
- Do not write implementation code, tests, deployment commands, or operational runbooks
