# Technology and Open-Source Research

Use this mode for repositories, libraries, protocols, AI models or products, AI Coding tools, and technology adoption comparisons.

## Required Checks

Apply the checks relevant to the research question. For adoption recommendations, cover decision-material fit, security, operability, cost, and exit-path dimensions. For a narrow factual question, do not expand into a full adoption assessment unless the answer depends on it.

- Identify the exact product form, repository, branch/tag/commit, version, license, platform, authentication method, and subscription tier in scope
- Select current primary sources for the claim: documentation or schemas for contracts, source code for implementation, release history for version changes, and configuration or reproducible tests for effective behavior; issues and discussions establish reported behavior, not that every environment is affected
- Separate advertised capability, documented capability, source-level implementation, reproduced behavior, and production fitness
- Assess architecture fit, integration boundary, interoperability, data flow, security, privacy, supply chain, performance evidence, maintainability, support, and exit path
- For AI systems, distinguish model capability, host-product capability, tool availability, account entitlement, prompt behavior, and end-to-end system performance
- Compare alternatives against explicit decision criteria, including the current-state baseline when relevant
- For opportunity or adoption questions, inspect credible new approaches and the baseline's opportunity costs; distinguish proposed benefit mechanisms, observed results, and unsupported promises
- Rank decision-material unknowns by how much their answer could change the next decision. Propose the smallest useful verification with observable success and failure, resource or exposure bounds, and what result would change the conclusion; do not conduct it without the required authority
- State whether the evidence informs exploration, a bounded pilot, wider adoption, or production commitment. Hand off evidence and hypotheses to the owning workflow identified when framing the research; missing production proof alone is not a verdict against exploration

## Reproducibility Record

Record environment, version, configuration, dataset or prompt, steps, expected result, observed result, and limitations for any claimed test. If no test was run, label the conclusion documentation-derived.

## Failure Patterns

- Stars, download counts, recent commits, or benchmark leadership used as a proxy for fitness
- README or vendor claims repeated without inspecting constraints and version context
- A model demo generalized to an application, workflow, or production guarantee
- Community configuration copied without threat-model, platform, or rollback analysis
