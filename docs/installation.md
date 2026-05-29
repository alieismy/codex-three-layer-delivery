# Installation

This repository provides templates. Merge them into your local Codex and project setup rather than overwriting existing files blindly.

## Codex Rules

Install global rules:

```bash
cp codex/global/AGENTS.md ~/.codex/AGENTS.md
```

Install project rules:

```bash
cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

If your destination already has `AGENTS.md`, merge manually and keep project-specific constraints.

## Skills

Global install:

```bash
cp -r skills/rd-* ~/.agents/skills/
```

Project-level install:

```bash
mkdir -p /path/to/your-project/.agents/skills
cp -r skills/rd-* /path/to/your-project/.agents/skills/
```

## Codex Configuration

Start from the safe example:

```bash
cp codex/examples/config.example.toml ~/.codex/config.toml
```

If a config already exists, merge only the relevant sections.

The full-access profile is opt-in:

```text
codex/examples/config.full-access.example.toml
```

Do not use full access for untrusted repositories.

## Environment Variables

Copy the environment example:

```bash
cp .env.example .env
```

Fill only the API keys for MCP servers you enable. Never commit `.env`.

On Windows, user-level environment variables can also be set with `setx`, but restart your shell, Codex CLI, or Codex app after changing them.

## Cursor Adapter

Install the English Cursor adapter:

```bash
cp -r cursor/project/.cursor /path/to/your-project/.cursor
cp cursor/project/PROMPTS.md /path/to/your-project/PROMPTS.cursor.md
```

Install the Simplified Chinese Cursor pack:

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
```

If the target workspace already has `.cursor/`, merge manually.

Cursor MCP is intentionally opt-in. Review credentials and data flow, then copy the example to the Cursor project MCP location:

```bash
cp cursor/project/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

The Cursor adapter is optional and should be kept aligned with the Codex and Claude Code adapters when rules change.

## Simplified Chinese Pack

The Simplified Chinese translation pack is available under:

```text
zh-CN/
```

Install Chinese Codex rules:

```bash
cp zh-CN/codex/global/AGENTS.md ~/.codex/AGENTS.md
cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

Install Chinese shared skills:

```bash
cp -r zh-CN/skills/rd-* ~/.agents/skills/
```

Install Chinese Claude Code files:

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

The English root remains the canonical baseline. Use `zh-CN/` as a translation pack and merge manually if destination files already exist.

## Claude Code Adapter

Install user-level Claude Code memory:

```bash
cp claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

Install project-level Claude Code rules and skills:

```bash
cp claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r claude/project/.claude /path/to/your-project/.claude
```

If the target workspace already has `CLAUDE.md` or `.claude/`, merge manually.

The Claude Code adapter is optional and should be kept aligned with the Codex rules when rules change.
