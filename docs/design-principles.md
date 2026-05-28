# Design Principles

## Deliverable-Driven Work

The framework routes work toward concrete deliverables:

- requirements documents;
- technical proposals;
- detailed designs;
- implementation diffs;
- review findings;
- tests and test reports;
- deployment runbooks.

## Minimal Necessary Change

Agent work should be narrow enough that every changed line can be traced to the user's request.

Avoid:

- opportunistic refactors;
- unrelated formatting churn;
- speculative abstractions;
- dependencies that are not required by the task.

## Evidence Discipline

Claims should be backed by the strongest practical evidence:

1. code or observed system behavior;
2. official documentation, standards, or RFCs;
3. papers or technical reports;
4. engineering practice articles;
5. clearly labeled inference.

## Safety Defaults

Public templates must be safer than private local setups:

- conservative sandbox defaults;
- explicit opt-in for full access;
- no real credentials;
- no private relay endpoints;
- no unverified model or package claims as defaults.

## Periodic Review

Rules that compensate for model limitations should be reviewed after major model or tool releases.

Rules that encode project-inherent engineering discipline should remain stable unless the project operating model changes.
