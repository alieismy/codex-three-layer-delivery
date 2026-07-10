---
name: rd-specification
description: >-
  Use when drafting or revising national, industry, enterprise, internal, or
  project standards, specifications, guidelines, and normative clauses. Apply
  when clause wording, governing drafting rules, terminology, references, or
  standards alignment must be changed. Use rd-review instead for an independent
  severity-graded review verdict. Do not use for implementation or execution.
---

# rd-specification

Support **standards and specification work** with clause-level rigor, evidence discipline, and normative wording control.

## Deliverables

- Standards/specification draft outline or clause draft
- Clause-level issue and revision table
- Normative wording replacement proposals
- Terminology and reference consistency checklist
- Open issues requiring expert, legal, standards-body, or domain-owner confirmation

## Execution Steps

### 1. Scope and Authority Confirmation

- Identify the standard type: national, industry, enterprise, internal guideline, or project specification
- Confirm the document status: draft, review draft, approval draft, published baseline, or revision
- Identify the target audience and expected authority of the document
- Confirm whether the work is drafting, revision, clause analysis, comparison, or gap analysis
- Identify the governing drafting rules and normative vocabulary for the target standards body or organization; do not assume one universal shall/should convention

### 2. Evidence Source Hierarchy

Prefer sources in this order:

1. Current target document text and clause numbering
2. Binding laws, regulations, standards, or official specifications
3. Referenced standards and normative documents
4. Approved upstream project documents or organizational rules
5. Expert judgment, clearly labeled as judgment rather than fact

When evidence is missing, mark "insufficient evidence, requires human verification" instead of inventing a basis.

### 3. Clause-Level Analysis

For each issue or proposal:

- Quote or identify the exact clause, table, figure, or term being discussed
- State the issue type: correctness, consistency, enforceability, ambiguity, scope, terminology, reference, or format
- Explain the evidence and reasoning
- Provide a replacement wording proposal when possible
- Distinguish mandatory requirements from recommendations and informative notes

### 4. Normative Wording Control

- Use clear mandatory language for requirements and avoid vague verbs such as "support", "optimize", or "improve" unless they are defined
- Avoid unverifiable adjectives such as "advanced", "secure", "fast", or "reliable" without criteria
- Keep terms consistent with the glossary and referenced standards
- Avoid adding implementation-specific details unless the standard intentionally constrains implementation

### 5. Consistency and Traceability Checks

- Cross-check terminology, abbreviations, symbols, tables, figures, and references
- Check whether requirements conflict across clauses or with referenced documents
- Confirm that each mandatory clause is testable, inspectable, or otherwise verifiable
- List unresolved conflicts and required decision owners

## Spec Injection Check

Pre-execution checks:

- Required standards template, numbering convention, and drafting rules
- Glossary and normative references
- Existing review comment format
- Domain-specific compliance, safety, cybersecurity, or industry requirements

## Tool Selection

- Use `rd-research` for current standards status, regulations, official interpretations, or external technical facts
- Prefer standards bodies, regulators, official specifications, and inspected normative sources
- Use Context7 or an equivalent documentation retriever only when a clause depends on current software, protocol, SDK, or API behavior
- When authoritative text is inaccessible, verify metadata only and mark clause content for human confirmation

## Quality Gates

Pre-delivery checklist:

- [ ] Every clause issue or proposal references a specific clause, table, figure, or term
- [ ] Evidence level is explicit; unsupported claims are marked for human verification
- [ ] Normative wording is clear, testable, and scope-bounded
- [ ] Terminology and references are consistent
- [ ] Replacement wording is provided for major issues when possible
- [ ] Mandatory, recommended, and informative content are not mixed
- [ ] No invented standard clauses, document statuses, or source claims

## Out of Scope

- Do not fabricate standards text, publication status, or legal authority
- Do not cite inaccessible or unverified standards as if their content were known
- Do not convert expert preference into a mandatory requirement without authority
- Do not perform code implementation, testing, deployment, or runtime verification
