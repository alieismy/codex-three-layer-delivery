# Cursor Prompt Templates

Use these short prompts in Cursor Agent chat. Replace `{placeholders}` with project-specific details.

The root `PROMPTS.md` contains the full template set. This file provides Cursor-specific short forms for the packaged `.cursor/skills/rd-*` document-delivery skills. Coding, code review, testing, and deployment execution are intentionally out of scope.

## Requirements

```text
Use /rd-requirement

Structure the following raw requirement into a verifiable PRD.

Raw requirement:
{paste the user's original wording}

Known constraints:
- Stakeholders: {roles}
- Business / policy constraints: {constraints}
- System / technical constraints: {constraints or TBD}
- Timeline / budget: {constraints}
```

## Research Evidence

```text
Use /rd-research

Collect and validate evidence for:
{decision, document section, standard clause, technology choice, policy question, or review claim}

Downstream use:
{rd-feasibility / rd-solution / rd-specification / rd-design / rd-review}

Expected output:
source table with authority, date/version context, relevance, confidence, conflicts, gaps, and citation-ready notes.
```

## Feasibility

```text
Use /rd-feasibility

Evaluate whether {project / solution / feature} is feasible.

Decision question:
{what needs to be judged}

Inputs:
{PRD, meeting notes, policy, existing system docs, or pasted context}

Compare viable options and separate facts, assumptions, estimates, and unknowns.
```

## Technical Proposal

```text
Use /rd-solution

Write a technical proposal / high-level design for:
{system or project}

Requirements source:
{file path or summary}

Feasibility input:
{file path or conclusion, if any}

Constraints:
- Existing systems: {boundaries}
- Security / compliance: {requirements}
- Performance / capacity: {targets}

Compare candidate solutions and recommend one.
```

## Detailed Design

```text
Use /rd-design

Create a detailed design for:
{module, subsystem, interface, data domain, or process}

Include module boundaries, interfaces, data model, critical flows, errors, security, auditability, concurrency, and unresolved decisions.
```

## Standards Work

```text
Use /rd-specification

Draft or revise the following standard or specification clauses:
{paste clauses or reference file path}

Requirements:
- Cite or identify the exact clause for every issue
- Do not invent standards evidence
- Mark insufficient evidence as requiring human verification
- Provide replacement normative wording when possible
```

## Document Review

```text
Use /rd-review, {Requirements Review / Feasibility Review / Proposal Review / Design Review / Standards Review} mode

Review target:
{document name, version, or file path}

Review focus:
- {focus area 1}
- {focus area 2}

Lead with severity-graded findings, evidence, impact, and concrete recommendations.
```
