# Codex Three-Layer Delivery

An unofficial, deliverable-driven rules-and-skills framework for Codex-first system design, architecture documentation, feasibility analysis, and document review.

This repository packages a three-layer operating model:

1. **Global directives**: personal behavioral rules for accuracy, evidence discipline, and response style.
2. **Project document-delivery discipline**: project-level `AGENTS.md` rules for scope control, quality gates, security, MCP routing, and verification.
3. **Research and document-delivery skills**: eight independent specialist `rd-*` skills plus one explicit delivery orchestrator for requirements, feasibility studies, evidence research, technical proposals, detailed designs, standards work, professional writing, independent review, and cross-session handoff.

It also includes optional Cursor and Claude Code adapter areas for teams that want to port the same document-delivery discipline to other agent environments.

> This project is independent and is not affiliated with OpenAI, Cursor, Anthropic, or any referenced framework. See `ATTRIBUTION.md` for inspiration references.

Simplified Chinese users can start from `zh-CN/`. The English root remains the canonical baseline; `zh-CN/` is a translation pack, `cursor/project/` is the English Cursor adapter, and `cursor/zh-CN/` remains the Cursor-specific Simplified Chinese compatibility pack.

## Who This Is For

Use this repository if you want AI agents to produce verifiable system-design and documentation deliverables instead of unstructured chat output.

It is designed for:

- system designers, solution architects, and technical leads writing PRDs, feasibility reports, proposals, and designs;
- product managers who need requirements to remain structured, prioritized, and traceable;
- standards contributors and reviewers working on national, industry, enterprise, or internal specifications;
- teams that need explicit evidence discipline, clause-level review rigor, and final verification reporting.

## Architecture

```text
Layer 1: Global AGENTS.md
  ~/.codex/AGENTS.md
  - language and tone
  - truthfulness and anti-anchoring
  - reasoning and response patterns

Layer 2: Project AGENTS.md
  {project}/AGENTS.md
  - document delivery discipline
  - spec injection
  - document quality gates
  - security and MCP routing
  - task routing

Layer 3: Document Delivery Skills
  ~/.agents/skills/rd-*/SKILL.md or {project}/.agents/skills/rd-*/SKILL.md
  - rd-requirement
  - rd-feasibility
  - rd-research
  - rd-solution
  - rd-design
  - rd-specification
  - rd-writing
  - rd-review
  - rd-delivery (explicit orchestration only)

Adapter mappings:
  Cursor: cursor/project/.cursor/rules/ and cursor/project/.cursor/skills/
  Cursor zh-CN: cursor/zh-CN/.cursor/rules/ and cursor/zh-CN/.cursor/skills/
  Claude Code: claude/project/CLAUDE.md and claude/project/.claude/skills/
  Simplified Chinese: zh-CN/
```

## Quick Start

### 1. Install Codex rules

```bash
# Global directives: first-time install only
mkdir -p ~/.codex
if [ ! -e ~/.codex/AGENTS.md ]; then
  cp codex/global/AGENTS.md ~/.codex/AGENTS.md
fi

# Project document-delivery discipline: only when the target does not exist
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

If a destination already exists, create a separate backup first, then merge only the relevant sections. Do not replace an existing personal global file or project rules blindly. These templates contain opinionated defaults for role, language behavior, reasoning depth, authorization, and delivery discipline; adapt them to the user, team, and repository. The English global template is language-neutral, while the `zh-CN/` template intentionally defaults to Simplified Chinese.

### 2. Install skills

```bash
# Global install: available to all projects
cp -r skills/rd-* ~/.agents/skills/

# Or project-level install
mkdir -p /path/to/your-project/.agents/skills
cp -r skills/rd-* /path/to/your-project/.agents/skills/
```

For a verified PowerShell user-level install with backup and exact tree comparison:

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -CheckOnly
```

### 3. Review Codex config examples

Start from the safe example:

```bash
cp codex/examples/config.example.toml ~/.codex/config.toml
```

If you already have `~/.codex/config.toml`, merge only the sections you need.

The high-permission profile is intentionally separate:

```text
codex/examples/config.full-access.example.toml
```

Use it only for trusted local workspaces where broad filesystem access is explicitly acceptable.

### 4. Configure optional MCP credentials

```bash
cp .env.example .env
```

Fill only the keys for MCP servers you actually enable.

### 5. Use Simplified Chinese templates

Use the Simplified Chinese translation pack:

```text
zh-CN/
```

Cursor English files are available under:

```text
cursor/project/
```

Cursor-specific Chinese files remain under:

```text
cursor/zh-CN/
```

## Skill Reference

| Skill | Primary deliverable | Typical use |
|---|---|---|
| `$rd-requirement` | Structured requirements / PRD | turn raw user needs into verifiable requirements |
| `$rd-feasibility` | Feasibility study / feasibility analysis | evaluate technical, economic, schedule, compliance, operational, and risk feasibility |
| `$rd-research` | Evidence package / research notes / fact-check matrix | research standards, open source, AI tools, configuration behavior, and contested claims |
| `$rd-solution` | Technical proposal / high-level design / construction plan | compare candidate solutions and produce design-ready technical documents |
| `$rd-design` | Detailed design | define interfaces, data models, flows, errors, security, and concurrency |
| `$rd-specification` | Standards/specification draft or clause revision | draft or revise standards and normative clauses |
| `$rd-writing` | Technical article / white paper / evidence report / decision brief | turn verified material into audience-ready professional documents |
| `$rd-review` | Independent review findings | review engineering documents, research reports, standards, and technical or public-affairs articles |
| `$rd-delivery` | Delivery charter / artifact map / phase gates / handoff | explicitly coordinate multi-stage, multi-document, or cross-session engagements |

The eight specialist Skills are independent and are not a forced pipeline. Use `$rd-research` when external or contested evidence is needed, `$rd-writing` when verified evidence must become an audience-ready narrative, and `$rd-review` when an independent verdict is required. Invoke `$rd-delivery` only when the user explicitly requests cross-artifact orchestration, phase gates, or a durable handoff. This boundary is encoded with `agents/openai.yaml` for Codex and with platform-specific `disable-model-invocation: true` frontmatter in the Claude and Cursor adapters.

Each skill includes output and trigger-boundary cases under `evals/` plus ChatGPT/Codex desktop metadata under `agents/openai.yaml`. Multi-mode Skills keep their common workflow in `SKILL.md` and load only the selected checklist from `references/`. Shared bodies use neutral `rd-*` identifiers; Codex examples use `$rd-*`, while explicit Cursor and Claude Code invocation uses `/rd-*`.

See [RD Skills Assessment and Evolution](docs/rd-skills-assessment.md) for the role-coverage matrix, non-goals, external design evidence, and the reason the taxonomy contains eight specialist Skills plus one explicit orchestrator.

## Cursor Adapter

The `cursor/` directory contains Cursor adapter documentation, an English adapter, and a Simplified Chinese compatibility pack:

```text
cursor/
  README.md
  project/
    .cursor/rules/*.mdc
    .cursor/skills/rd-*/SKILL.md
    .cursor/mcp.example.json
    PROMPTS.md
  zh-CN/
    .cursor/rules/*.mdc
    .cursor/skills/rd-*/SKILL.md
    .cursor/mcp.example.json
    PROMPTS.md
```

Codex remains the primary target of this repository. Treat Cursor support as optional. The Cursor MCP file is published as `mcp.example.json`; copy it to `.cursor/mcp.json` only after reviewing credentials, data flow, and the target workspace's MCP status.

## Simplified Chinese Pack

The `zh-CN/` directory contains a Simplified Chinese translation pack for Codex, Claude Code, shared `rd-*` skills, documentation, and prompts.

```text
zh-CN/
  README.md
  PROMPTS.md
  codex/
  claude/
  skills/
  docs/
```

The English root is the canonical baseline. Use `zh-CN/` as a translation pack, not as a separate source of truth. Cursor English support is in `cursor/project/`; Cursor-specific Chinese support remains in `cursor/zh-CN/`.

## Claude Code Adapter

The `claude/` directory contains a Claude Code compatibility pack:

```text
claude/
  README.md
  global/CLAUDE.md
  project/CLAUDE.md
  project/.claude/settings.json
  project/.claude/skills/rd-*/SKILL.md
```

Codex remains the primary target of this repository. Treat Claude Code support as optional and re-check Claude Code file conventions before changing `CLAUDE.md`, `.claude/settings.json`, or `.claude/skills/` behavior.

## Safety Defaults

The public configuration intentionally uses conservative defaults:

- no `danger-full-access` by default;
- no Windows elevated sandbox by default;
- no hardcoded personal model name;
- no default third-party relay URL;
- optional MCP servers are disabled until credentials and use cases are reviewed;
- Cursor adapter MCP config is shipped as `mcp.example.json`, not as an active `.cursor/mcp.json`;
- Claude Code project settings deny common secret files and require confirmation for commit, push, tag, publish, and delete operations;
- package versions are documented in `docs/compatibility.md` and should be refreshed before release;
- Context7's tested version is pinned consistently across the compatibility documents and all Codex/Cursor examples, with client-runtime acceptance kept as a separate evidence layer.

## Repository Layout

```text
codex-three-layer-delivery/
  codex/
    global/AGENTS.md
    project/AGENTS.md
    examples/
      config.example.toml
      config.full-access.example.toml
  cursor/
    README.md
    project/.cursor/rules/
    project/.cursor/skills/
    project/.cursor/mcp.example.json
    zh-CN/.cursor/rules/
    zh-CN/.cursor/skills/
    zh-CN/.cursor/mcp.example.json
  zh-CN/
    README.md
    PROMPTS.md
    codex/
    claude/
    skills/
    docs/
  claude/
    README.md
    global/CLAUDE.md
    project/CLAUDE.md
    project/.claude/settings.json
    project/.claude/skills/
  skills/
    rd-*/SKILL.md
  docs/
    compatibility.md
    installation.md
    mcp-routing.md
    design-principles.md
    release-checklist.md
  scripts/
    validate.ps1
    test-validator.ps1
  PROMPTS.md
  ATTRIBUTION.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
```

## Validation

Run the local repository checks:

```powershell
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
```

The validator checks common release blockers:

- CRLF drift in Markdown, TOML, MDC, and script files;
- missing or invalid Skill frontmatter, per-step completion criteria, metadata, and eval coverage;
- inconsistent mirrored Skill directory sets or file content;
- missing always-on evidence-state and no-change controls across Codex, Claude, and Cursor surfaces;
- Context7 version drift across compatibility documents and Codex/Cursor examples;
- unsafe defaults in the public Codex config example;
- a missing `.tmp/local/` boundary;
- obvious secret leaks;
- stale private/internal strings.

The negative-test runner copies the current repository into verified system-temporary directories and proves that the real validator rejects six regression cases: distribution-preserving completion-criterion drift, Context7 cross-file version drift, an `rd-delivery` invocation-policy regression, loss of the always-on evidence/no-change contract, loss of the RD specialist Skill/eval/near-miss contract, and loss of the `.tmp/local/` boundary.

## Versioning

Use GitHub releases and tags for versions, for example `v4.0.0`.

Avoid encoding version or language into the repository name. Keep the repository name stable and put edition-specific details in documentation or release notes.

Repository maintainers should follow the [release checklist](docs/release-checklist.md). It governs publication of this repository and does not expand the RD Skills into release-operation workflows.

## License

MIT. See `LICENSE`.
