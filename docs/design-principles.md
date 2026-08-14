# Design Principles

## Deliverable-Driven Work

The framework routes work toward concrete deliverables:

- requirements documents;
- feasibility studies;
- evidence packages and source notes;
- technical proposals;
- high-level designs and construction plans;
- detailed designs;
- standards and specification drafts;
- review findings;
- clause-level revision recommendations.

## Minimal Necessary Change

Agent work should be narrow enough that every changed line can be traced to the user's request.

Avoid:

- opportunistic refactors;
- unrelated formatting churn;
- speculative abstractions;
- dependencies that are not required by the task.

## Evidence Discipline

Claims should be backed by the strongest practical evidence:

1. target document text, quoted clauses, or approved upstream requirements;
2. official documentation, standards, laws, regulations, or RFCs;
3. system facts, architecture records, or observed behavior;
4. papers or technical reports;
5. engineering practice articles;
6. clearly labeled inference.

For standards work, do not invent clause text, document status, publication dates, or authority. If evidence is missing, mark it as requiring human verification.

Use evidence-package work when external facts, standards metadata, literature, policy, market data, or vendor claims materially affect a downstream document. Evidence collection supports feasibility studies, technical proposals, standards work, and reviews, but it is not a mandatory first stage for every task.

Source authority and evidence state are separate dimensions. Record the highest state actually established: documentation claim, source implementation, static configuration, final generated or effective configuration, runtime state, or business/production acceptance. A lower state never proves a higher one. If the evidence supports retaining the current state, a bounded no-change conclusion is valid and should not be replaced with manufactured optimization work.

## Safety Defaults

Public templates must be safer than private local setups:

- conservative sandbox defaults;
- explicit opt-in for full access;
- no real credentials;
- no private relay endpoints;
- no unverified model or package claims as defaults.

## Periodic Review

Rules that compensate for model limitations should be reviewed after major model or tool releases.

Rules that encode project-inherent document-delivery discipline should remain stable unless the project operating model changes.

## Excluded Work

The RD Skills intentionally exclude coding, code review, test authoring/execution, deployment execution, and release execution. Deployment architecture may appear inside a construction plan, but deployment runbooks and operational commands are out of scope. Repository maintainers use the separate [release checklist](release-checklist.md) to publish this framework; that governance process is not an RD Skill deliverable and does not expand Skill responsibility.
