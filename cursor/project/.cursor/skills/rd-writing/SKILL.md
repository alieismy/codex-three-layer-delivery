---
name: rd-writing
description: >-
  Write source-backed technical articles, white papers, research or fact-check
  reports, decision briefs, and other professional explanatory documents. Use
  when verified evidence must be shaped for a real audience and publication or
  decision purpose without losing uncertainty, counterarguments, or traceability.
  Do not use for PRDs, architecture selection, detailed design, standards, or review.
---

# rd-writing

Turn verified material into an audience-ready professional document whose claims, logic, and evidence remain auditable.

## Deliverables

- Technical article, explanatory article, or technical white paper
- Research synthesis or fact-check report
- Decision brief, position paper, or evidence-led recommendation memo
- Claim-source map and unresolved evidence notes when material

## Select an Output Mode

Read only the reference needed for the target:

| Mode | Target | Reference |
|------|--------|-----------|
| Technical article | technical article, explanatory article, technical white paper | [technical-article.md](references/technical-article.md) |
| Evidence report | research synthesis, fact-check report, evidence review | [evidence-report.md](references/evidence-report.md) |
| Decision brief | decision memo, position paper, executive technical brief | [decision-brief.md](references/decision-brief.md) |

## Common Workflow

### 1. Pin the Writing Contract

- Confirm audience, decision or publication purpose, scope, genre, length, tone, date boundary, and required citation style
- Identify supplied source material, claims that require current verification, and any editorial or organizational constraints
- Preserve established terminology, names, dates, quotations, numbering, and traceability
- If the user supplies a desired conclusion, treat it as a proposition to test rather than a fact to defend

**Completion criterion:** audience, purpose, scope, mode, date boundary, source set, tone, length, and citation contract are explicit.

### 2. Establish the Claim Architecture

- State the central question and candidate conclusion
- Build a claim hierarchy: central claim, supporting claims, evidence, counterclaims, limitations, and implications
- Separate fact, estimate, inference, prediction, opinion, and value judgment
- Remove claims that are irrelevant to the document purpose or unsupported by available evidence

**Completion criterion:** every retained claim supports the document purpose, has a claim type, and maps to evidence, reasoning, counterclaim, limitation, or an explicit verification gap.

### 3. Verify Before Drafting

- Inspect supplied and project sources first; use `rd-research` for volatile, disputed, external, or decision-critical claims
- Resolve timeline, version, jurisdiction, units, denominator, quotation context, and source ownership where material
- Record conflicts and evidence gaps; do not let polished prose conceal uncertainty

**Completion criterion:** every decision-critical or publishable factual claim is verified to the required precision or bounded in the planned wording before prose drafting begins.

### 4. Draft for the Audience

- Lead with the answer or decision relevance unless the genre requires another structure
- Use the minimum sufficient structure and explain specialized terms only when audience knowledge requires it
- Present the strongest material counterargument fairly before rebutting it
- Keep evidence close to the claim it supports and distinguish sourced facts from the author's analysis
- Use tables only for genuine comparison and diagrams only when they clarify structure, flow, or causality

**Completion criterion:** the draft answers the central question for the target audience, preserves evidence boundaries and counterarguments, and contains no section without a decision or explanatory purpose.

### 5. Edit and Verify

- Check factual accuracy, citation entailment, chronology, causal logic, internal consistency, terminology, and numerical units
- Remove promotional, slogan-like, template-like, repetitive, and unsupported language
- Confirm the conclusion does not exceed the evidence and that limitations are specific rather than boilerplate
- Preserve a claim-source map for high-impact or contested documents

**Completion criterion:** every material claim, citation, number, quotation, term, and conclusion passes the final accuracy and entailment check, with unresolved limitations still visible.

## Tool Selection

- Use local document and repository inspection before external retrieval
- Use `rd-research` to build or refresh the evidence package; do not duplicate a deep research workflow inside drafting
- Use document-format Skills for `.docx`, PDF, presentation, or spreadsheet artifacts after the content is stable
- Use language-polish Skills only after factual and argumentative integrity is established

## Quality Gates

- [ ] Audience, purpose, scope, mode, and date boundary are explicit
- [ ] Central and supporting claims are evidence-backed and logically connected
- [ ] Facts, inferences, estimates, predictions, opinions, and examples are distinguishable
- [ ] Strong counterarguments and material limitations are represented fairly
- [ ] Citations support the adjacent claims and volatile facts carry time/version context
- [ ] Tone is professional and specific, without promotional or template filler
- [ ] Final conclusion stays within the evidence boundary

## Out of Scope

- Use `rd-requirement`, `rd-solution`, `rd-design`, or `rd-specification` when that structured deliverable is the actual target
- Use `rd-review` when the primary task is an independent verdict on an existing document
- Do not invent sources, quotations, data, examples presented as real, dates, or causal certainty
- Do not optimize persuasion by hiding counterevidence, uncertainty, or conflicts of interest
