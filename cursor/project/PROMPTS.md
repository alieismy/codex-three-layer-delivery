# Cursor Prompt Templates

Use these prompts in Cursor Agent chat. Replace `{placeholders}` with project-specific details.

The English root `PROMPTS.md` contains the full template set. This file provides Cursor-specific short forms for the packaged `.cursor/skills/rd-*` skills.

## Requirements

```text
Use $rd-requirements-analysis

Structure the following raw requirement into a verifiable PRD.

Raw requirement:
{paste the user's original wording}

Known constraints:
- Tech stack: {stack or TBD}
- Users: {target users}
- Timeline: {timeline}
```

## Technical Proposal

```text
Use $rd-technical-writing

Write a technical proposal for:
{feature or system}

Requirements source:
{file path or summary}

Constraints:
- Tech stack: {stack}
- Deployment: {environment}
- Performance: {targets}

Compare at least two viable approaches and recommend one.
```

## Detailed Design

```text
Use $rd-detailed-design

Create a detailed design for:
{module or feature}

Include interfaces, data model, critical flows, failure paths, and concurrency considerations.
```

## Implementation

```text
Use $rd-implement

Implement:
{specific task}

Scope:
- {file or module}: {expected change}

Acceptance criteria:
- {observable behavior}
- {verification command or test}
```

## Code Review

```text
Use $rd-code-review

Review the current changes.

Focus:
- correctness
- security
- maintainability
- missing tests
```

## Testing

```text
Use $rd-testing

Design and run tests for:
{feature or module}

Cover normal, abnormal, and boundary scenarios. Record failures and root cause analysis.
```

## Deployment

```text
Use $rd-deployment

Create a deployment runbook for:
{service or release}

Target environment:
{environment}

Include rollback and post-deployment verification.
```
