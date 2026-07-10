---
name: rd-research
description: >-
  Use when collecting, validating, and structuring external or project evidence
  for requirements, feasibility, solution, design, standards, or review work.
  Apply when literature, policy, standards, vendor documentation, technical
  maturity, cost assumptions, or industry cases materially affect a conclusion.
  Do not use as a mandatory first step or as a substitute for unavailable evidence.
---

# rd-research

Produce a **traceable evidence package** for downstream document-delivery outputs and reviews.

## Deliverables

- Research questions and decision dependencies
- Search strategy and query log when external search is used
- Evidence/source table with authority, date, relevance, and confidence
- Key findings, conflicts, gaps, and assumptions
- Citation-ready notes for downstream documents
- Recommendation on which downstream Skill should use the evidence

## Execution Steps

### 1. Research Scope

- State the decision or document section that depends on evidence
- Convert broad topics into concrete research questions
- Separate required evidence from optional background material
- Identify whether the evidence supports `rd-feasibility`, `rd-solution`, `rd-specification`, `rd-design`, `rd-requirement`, or `rd-review`

### 2. Source Hierarchy

Prefer sources in this order:

1. User-provided target documents and authoritative project materials
2. Binding laws, regulations, standards, and official policy documents
3. Official vendor, framework, protocol, or product documentation
4. Peer-reviewed papers, technical reports, and standards-body materials
5. Industry case studies, reputable analyst reports, and public references
6. Expert inference, explicitly labeled as inference

Do not cite a source as evidence unless the relevant content has been inspected.

### 3. Search and Collection

- Prefer English keywords for broad technical and standards searches; present final output in the user's requested language
- Record the main query intent, source type, and retrieval date for volatile facts
- Use multiple source types for important claims instead of relying on one result
- For paywalled or inaccessible standards, only cite metadata that was actually verified and mark clause content as unavailable

### 4. Source Evaluation

Evaluate each useful source:

| Dimension | Check Content |
|-----------|---------------|
| Authority | official / standards body / vendor / academic / industry / media |
| Currency | publication date, version, latest revision, deprecation status |
| Relevance | direct evidence / indirect support / background only |
| Reliability | primary source, secondary summary, conflict with other sources |
| Applicability | jurisdiction, industry, system boundary, scenario fit |
| Confidence | high / medium / low / unknown |

### 5. Evidence Synthesis

- Summarize findings in decision-oriented language
- Mark conflicts between sources and explain which source should dominate
- Distinguish facts, assumptions, estimates, interpretations, and recommendations
- List evidence gaps and specific follow-up verification actions
- Keep raw research separate from final document wording unless the user asks for a full document

## Tool Selection

- Use the narrowest configured capability that reaches the source owner: official documentation retrieval, current web search, repository inspection, or browser/PDF inspection
- Prefer Context7 or an equivalent documentation retriever only for current framework, library, SDK, or API documentation
- Use repository-oriented tools only for facts grounded in the inspected public repository, not as authority for general best practices
- Use native reasoning for synthesis; optional reasoning tools must not replace inspected evidence
- If a capability is unavailable, record the limitation and continue with the evidence that can be inspected

## Quality Gates

Pre-delivery checklist:

- [ ] Research questions and downstream document dependency are explicit
- [ ] Important claims have inspected sources or are marked as assumptions
- [ ] Source authority, currency, relevance, and confidence are visible
- [ ] Volatile facts include retrieval date or version context when needed
- [ ] Conflicting evidence is disclosed instead of flattened into one answer
- [ ] Unsupported or inaccessible evidence is marked for human verification
- [ ] No fabricated citations, standards clauses, market data, or vendor claims

## Out of Scope

- Do not treat `rd-research` as a mandatory first step for every task
- Do not write final PRDs, feasibility reports, solution documents, detailed designs, specifications, or review reports unless explicitly asked
- Do not cite uninspected search snippets as confirmed facts
- Do not invent dates, versions, legal requirements, standards clauses, cost figures, or benchmark results
