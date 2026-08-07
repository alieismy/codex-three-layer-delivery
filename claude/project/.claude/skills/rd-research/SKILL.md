---
name: rd-research
description: >-
  Research and verify decision-critical claims using project evidence and
  inspected primary sources. Use for standards or policy evidence, open-source
  and AI-tool evaluation, API or product facts, network or system configuration
  research, literature review, and technical or public-affairs fact-checking.
  Produce traceable evidence, not an unsupported answer or final design.
---

# rd-research

Produce a **traceable, decision-oriented evidence package** that downstream documents and reviews can audit.

## Deliverables

- Research question, decision dependency, scope, and stopping condition
- Search strategy and query log when external retrieval is used
- Claim-evidence matrix with authority, date/version, applicability, and confidence
- Key findings, conflicts, gaps, assumptions, and falsifying evidence
- Citation-ready notes and a recommended downstream handoff

## Select a Research Mode

Read only the reference needed for the target:

| Mode | Use for | Reference |
|------|---------|-----------|
| Evidence support | laws, standards, papers, vendor facts, cost or market evidence for another `rd-*` Skill | use the common workflow below |
| Technology and open source | repositories, libraries, AI Coding tools, LLM products, protocols, maintainability or adoption comparisons | [technology-research.md](references/technology-research.md) |
| Configuration and infrastructure | Windows/Linux, VPN, VPS, proxy, network, security, installation or configuration behavior | [configuration-research.md](references/configuration-research.md) |
| Fact-check and argument evidence | technical articles, public-affairs articles, timelines, quotations, causal or quantitative claims | [fact-check-research.md](references/fact-check-research.md) |

If the target spans modes, choose one primary mode and load a second reference only for a material secondary question.

## Common Workflow

### 1. Frame the Research

- State the decision or document section that depends on the result
- Decompose broad topics into answerable claims or research questions
- Record scope, jurisdiction, relevant date/version, required precision, and stopping condition
- Separate facts to retrieve from decisions that require user or stakeholder authority
- Identify whether the evidence supports `rd-requirement`, `rd-feasibility`, `rd-solution`, `rd-design`, `rd-specification`, `rd-writing`, or `rd-review`

**Completion criterion:** every research question is answerable within a stated scope and stopping condition, and user-owned decisions are separated from retrievable facts.

### 2. Use a Source Hierarchy

Prefer the source closest to ownership of the claim:

1. User-provided target material, system observations, logs, source code, and authoritative project records
2. Binding laws, regulations, standards, official policy, and first-party statements or datasets
3. Official product, vendor, framework, protocol, API, and repository documentation
4. Original papers, technical reports, issue/commit/release history, and standards-body material
5. High-quality independent engineering analysis or reporting for context and cross-checking
6. Expert inference, explicitly labeled and never substituted for missing evidence

Forum, social-media, search-snippet, AI-generated, and aggregator content may supply leads but cannot alone establish a material conclusion.

**Completion criterion:** each material claim has a planned source class that is sufficiently authoritative and close to the claim owner, and any lower-tier substitution is explicit and justified.

### 3. Retrieve and Inspect

- Prefer English queries for broad technical research and present results in the requested language
- Inspect the relevant source content before citing it; do not cite a search result or abstract as if the underlying claim was verified
- Record retrieval date for volatile facts and exact version, edition, commit, jurisdiction, or environment when material
- Seek independent corroboration for high-impact claims and actively search for disconfirming evidence
- For inaccessible or paywalled material, report only verified metadata and mark unavailable content
- Redact secrets and unnecessary personal or infrastructure identifiers from captured commands, output, screenshots, and excerpts while retaining the source anchor and reproducibility boundary

**Completion criterion:** every cited source has been inspected at the level needed for the claim, volatile context is recorded, and material counterevidence or access limits are captured.

### 4. Evaluate Evidence

Assess each material source for authority, currency, directness, independence, applicability, reproducibility, and conflict of interest. Map each conclusion to evidence and label it as fact, estimate, inference, judgment, or unknown.

**Completion criterion:** every material conclusion has an evidence-strength and claim-type label, with conflicts and applicability limits preserved.

### 5. Synthesize and Hand Off

- Answer each research question directly and state the evidence strength
- Preserve disagreements and explain why one source should dominate, if justified
- Separate observed behavior from documented behavior and both from recommendation
- List evidence gaps, verification actions, and what would change the conclusion
- For multi-stage work, maintain one canonical evidence package in the repository's established location and link supporting notes rather than scattering final claims across temporary files
- Keep raw notes separate from publication-ready prose; use `rd-writing` for the final narrative and `rd-review` for an independent verdict
- Quote or preserve only the signal needed to support a claim; point to controlled raw evidence instead of copying sensitive or voluminous output into the handoff

**Completion criterion:** each research question has a bounded answer, evidence link, confidence or limitation, falsifier or follow-up where material, and one identifiable downstream handoff.

## Tool Selection

- Use the narrowest configured capability that reaches the source owner: local inspection, official documentation retrieval, repository tools, current web search, or browser/PDF inspection
- Use Context7 or an equivalent retriever for current library, framework, SDK, and API documentation; verify product, policy, pricing, and current-event claims with their owning sources
- Use repository-oriented tools only for facts grounded in the inspected repository; README claims do not prove runtime behavior
- Use native reasoning for synthesis; optional reasoning tools cannot replace evidence
- When a capability is unavailable, record the limitation and continue only within the remaining evidence boundary

## Quality Gates

- [ ] Scope, decision dependency, mode, and stopping condition are explicit
- [ ] Each material claim maps to inspected evidence or is labeled unverified
- [ ] Volatile facts include date/version/environment context where needed
- [ ] Primary and independent sources are distinguished; conflicts are preserved
- [ ] Counterevidence and alternative explanations were actively tested for high-impact claims
- [ ] Reproducibility limits, inaccessible evidence, and follow-up actions are explicit
- [ ] Evidence excerpts and handoffs exclude secrets and unnecessary sensitive identifiers
- [ ] Multi-stage work has one identifiable canonical evidence package rather than competing summaries
- [ ] No fabricated citations, quotations, clauses, dates, versions, metrics, or behavior

## Out of Scope

- Do not use `rd-research` as a mandatory first step for every task
- Do not treat popularity, repository activity, a demo, or a vendor claim as proof of fitness
- Do not produce a final PRD, feasibility report, design, standard, article, or independent approval verdict unless explicitly requested
- Do not perform unauthorized access, destructive testing, deployment, or production change
