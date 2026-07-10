# Codex Three-Layer Delivery

An unofficial, deliverable-driven rules-and-skills framework for Codex-first system design, architecture documentation, feasibility analysis, and document review.

This repository packages a three-layer operating model:

1. **Global directives**: personal behavioral rules for accuracy, evidence discipline, and response style.
2. **Project document-delivery discipline**: project-level `AGENTS.md` rules for scope control, quality gates, security, MCP routing, and verification.
3. **Document delivery skills**: seven independent `rd-*` skills for requirements, feasibility studies, research evidence, technical proposals, detailed designs, standards work, and document review.

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
  - rd-review

Adapter mappings:
  Cursor: cursor/project/.cursor/rules/ and cursor/project/.cursor/skills/
  Cursor zh-CN: cursor/zh-CN/.cursor/rules/ and cursor/zh-CN/.cursor/skills/
  Claude Code: claude/project/CLAUDE.md and claude/project/.claude/skills/
  Simplified Chinese: zh-CN/
```

## Quick Start

### 1. Install Codex rules

```bash
# Global directives
cp codex/global/AGENTS.md ~/.codex/AGENTS.md

# Project document-delivery discipline
cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

If the destination files already exist, merge the content manually. Do not blindly overwrite existing project rules.

### 2. Install skills

```bash
# Global install: available to all projects
cp -r skills/rd-* ~/.agents/skills/

# Or project-level install
mkdir -p /path/to/your-project/.agents/skills
cp -r skills/rd-* /path/to/your-project/.agents/skills/
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
| `$rd-research` | Evidence package / literature and source notes | collect and validate evidence for feasibility, solution, standards, or fact-dependent review work |
| `$rd-solution` | Technical proposal / high-level design / construction plan | compare candidate solutions and produce design-ready technical documents |
| `$rd-design` | Detailed design | define interfaces, data models, flows, errors, security, and concurrency |
| `$rd-specification` | Standards/specification draft or clause revision | draft or revise standards and normative clauses |
| `$rd-review` | Document review findings | review requirements, feasibility reports, proposals, designs, or standards |

The skills are independent. They are not a forced pipeline. Use `$rd-research` when external evidence is needed; it is a recommended companion for feasibility studies, technical proposals, standards work, and fact-dependent reviews, not a mandatory first step for every task.

Each skill includes output and trigger-boundary cases under `evals/`. `rd-review` keeps its common framework in `SKILL.md` and loads only the selected document-mode checklist from `references/`. Shared skill bodies use neutral `rd-*` identifiers; Codex examples use `$rd-*`, while explicit Cursor and Claude Code invocation uses `/rd-*`.

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
- package versions are documented in `docs/compatibility.md` and should be refreshed before release.

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
  scripts/
    validate.ps1
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
```

The validator checks common release blockers:

- CRLF drift in Markdown, TOML, MDC, and script files;
- missing skill frontmatter;
- inconsistent mirrored skill directory sets;
- unsafe defaults in the public Codex config example;
- obvious secret leaks;
- stale private/internal strings.

## Versioning

Use GitHub releases and tags for versions, for example `v4.0.0`.

Avoid encoding version or language into the repository name. Keep the repository name stable and put edition-specific details in documentation or release notes.

## License

MIT. See `LICENSE`.
