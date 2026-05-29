---
name: rd-deployment
description: >-
  Use when planning or executing installation, deployment, release management,
  writing runbooks, rollback plans, or post-deployment verification. Do not use
  for deployment architecture design (use rd-technical-writing instead).
---

# $rd-deployment

Plan and execute **installation and deployment**, producing repeatable deployment runbooks and change records.

> **Boundary with `$rd-technical-writing` Implementation Plan**: The implementation plan defines the deployment *design* (infrastructure topology, environment planning, deployment strategy, capacity planning); this Skill handles deployment *execution* (runbook, script authoring, rollback verification, change records). The implementation plan is one of this Skill's inputs.

## Deliverables

- Deployment runbook (step-by-step operations, rollback, verification)
- Deployment scripts / automation configuration (if applicable)
- Deployment change records
- Post-deployment verification checklist

## Execution Steps

### 1. Deployment Scope Confirmation

- Confirm deployment content: code version, configuration changes, database migrations, infrastructure changes
- Confirm target environment: development / testing / staging / production
- Confirm prerequisites and dependencies (including whether tests have passed via `$rd-testing`)
- Confirm deployment window and impact scope

### 2. Deployment Plan Authoring

#### Deployment Steps
- List operational commands or procedures step by step
- Annotate each step with expected result and timeout
- Mark critical checkpoints requiring human confirmation

#### Rollback Plan
- Rollback commands/operations for each critical step
- Rollback decision criteria (under what conditions to trigger rollback)
- Post-rollback verification steps
- Data rollback strategy (if database changes are involved)

#### Canary / Staged Rollout Strategy (if applicable)
- Batch ratios and cadence
- Observation metrics and progression criteria per batch
- Pause and rollback process on anomalies

### 3. Environment Checklist

| Check Item | Content |
|------------|---------|
| Version confirmation | Deployment package version, dependency versions |
| Configuration reconciliation | Environment variables, configuration file diffs |
| Resource readiness | Database connections, middleware, external services |
| Permission confirmation | Deployment account permissions, filesystem permissions |
| Backup confirmation | Database backup, configuration backup |

### 4. Deployment Execution

- Execute step by step according to the plan
- Record actual results for each step
- Log anomalies and decisions in real-time

### 5. Post-Deployment Verification

- Smoke test: core feature availability
- Monitoring check: error rates, response times, resource utilization
- Log inspection: no abnormal error logs
- Business verification: critical business flows operating normally

### 6. Change Records

Output standardized change records:
- Change timestamp, executor
- Change content summary
- Impact scope
- Verification results
- Outstanding issues

## Spec Injection Check

Pre-execution checks:
- Project deployment process and approval requirements
- Existing CI/CD pipeline configuration
- Environment management standards and access permissions
- Change management policy

## MCP Tool Usage

- **Context7**: Query deployment tool and infrastructure documentation
- **Playwright**: Automated smoke testing for web applications post-deployment

## Quality Gates

Pre-delivery checklist:

- [ ] Deployment steps are repeatably executable
- [ ] Rollback plan exists and is executable
- [ ] Critical checkpoints are annotated
- [ ] Post-deployment verification passed
- [ ] Change records are complete

## Out of Scope

- Do not skip the rollback plan
- Do not execute database changes without backups
- Do not perform untested operations in production environments
- Do not skip post-deployment verification
