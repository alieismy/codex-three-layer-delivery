# Design Review

## Dimensions

- Interface contracts: invariants, inputs, outputs, errors, ordering, versioning, idempotency
- Data model: lifecycle, constraints, indexes, consistency, retention, migration assumptions
- Critical flows: normal, exception, timeout, partial-success, retry, and recovery paths
- State and concurrency: valid transitions, races, locks, conflict handling
- Security: trust boundaries, authorization, validation, data protection, secrets, auditability
- Observability, error handling, implementability, and traceability to approved inputs

## Failure Hypotheses

- A caller must know undocumented implementation details to use an interface safely
- Partial failure or concurrent execution violates an invariant
- A security or data flow crosses an unmodeled trust boundary
- An unresolved design decision is presented as settled fact

## Evidence

Check actual platform constraints and current API behavior when they materially affect implementability.
