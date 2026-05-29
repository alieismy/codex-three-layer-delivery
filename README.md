# Codex Three-Layer Delivery

An unofficial, deliverable-driven rules-and-skills framework for Codex-first software R&D.

This repository packages a three-layer operating model:

1. **Global directives**: personal behavioral rules for accuracy, evidence discipline, and response style.
2. **Project engineering discipline**: project-level `AGENTS.md` rules for scope control, quality gates, security, MCP routing, and verification.
3. **R&D skills**: eight independent `rd-*` skills for requirements, design, implementation, review, testing, and deployment deliverables.

It also includes optional Cursor and Claude Code adapter areas for teams that want to port the same engineering discipline to other agent environments.

> This project is independent and is not affiliated with OpenAI, Cursor, Anthropic, or any referenced framework. See `ATTRIBUTION.md` for inspiration references.

Simplified Chinese users can start from `zh-CN/`. The English root remains the canonical baseline; `zh-CN/` is a translation pack, and `cursor/zh-CN/` remains the Cursor-specific compatibility pack.

## Who This Is For

Use this repository if you want AI coding agents to produce verifiable engineering deliverables instead of unstructured chat output.

It is designed for:

- senior engineers and architects using Codex on real repositories;
- teams that want repeatable requirements, design, review, testing, and deployment workflows;
- projects that need explicit evidence discipline, minimal-change execution, and final verification reporting.

## Architecture

```text
Layer 1: Global AGENTS.md
  ~/.codex/AGENTS.md
  - language and tone
  - truthfulness and anti-anchoring
  - reasoning and response patterns

Layer 2: Project AGENTS.md
  {project}/AGENTS.md
  - engineering discipline
  - spec injection
  - quality gates
  - security and MCP routing
  - task routing

Layer 3: R&D Skills
  ~/.agents/skills/rd-*/SKILL.md or {project}/.agents/skills/rd-*/SKILL.md
  - rd-requirements-analysis
  - rd-technical-writing
  - rd-detailed-design
  - rd-implement
  - rd-doc-review
  - rd-code-review
  - rd-testing
  - rd-deployment

Adapter mappings:
  Cursor: cursor/zh-CN/.cursor/rules/ and cursor/zh-CN/.cursor/skills/
  Claude Code: claude/project/CLAUDE.md and claude/project/.claude/skills/
  Simplified Chinese: zh-CN/
```

## Quick Start

### 1. Install Codex rules

```bash
# Global directives
cp codex/global/AGENTS.md ~/.codex/AGENTS.md

# Project engineering discipline
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

Cursor-specific Chinese files remain under:

```text
cursor/zh-CN/
```

## Skill Reference

| Skill | Primary deliverable | Typical use |
|---|---|---|
| `$rd-requirements-analysis` | Structured requirements / PRD | turn raw requests into verifiable requirements |
| `$rd-technical-writing` | technical proposal / high-level design | compare solutions and produce implementation plans |
| `$rd-detailed-design` | detailed design | define APIs, data models, flows, failures, and concurrency |
| `$rd-implement` | runnable code and tests | implement features, bug fixes, refactors |
| `$rd-doc-review` | document review findings | review requirements, proposals, or detailed designs |
| `$rd-code-review` | code review findings | review diffs, PRs, commits, or current working trees |
| `$rd-testing` | test plan / tests / test report | design, run, and evaluate test coverage |
| `$rd-deployment` | runbook / release checklist | plan and verify deployment or rollback |

The skills are independent. They are not a forced pipeline.

## Cursor Adapter

The `cursor/` directory contains adapter documentation and a `zh-CN` compatibility pack:

```text
cursor/
  README.md
  zh-CN/
    .cursor/rules/*.mdc
    .cursor/skills/rd-*/SKILL.md
    PROMPTS.md
```

Codex remains the primary target of this repository. Treat Cursor support as optional until the adapter you need has been translated and re-verified.

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

The English root is the canonical baseline. Use `zh-CN/` as a translation pack, not as a separate source of truth. Cursor-specific Chinese support remains in `cursor/zh-CN/`.

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
    zh-CN/.cursor/rules/
    zh-CN/.cursor/skills/
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
- unsafe defaults in the public Codex config example;
- obvious secret leaks;
- stale private/internal strings.

## Versioning

Use GitHub releases and tags for versions, for example `v4.0.0`.

Avoid encoding version or language into the repository name. Keep the repository name stable and put edition-specific details in documentation or release notes.

## License

MIT. See `LICENSE`.
