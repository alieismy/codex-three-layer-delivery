# Installation

This repository provides templates. Merge them into your local Codex and project setup rather than overwriting existing files blindly.

## Codex Rules

Install global rules:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi
```

Install project rules:

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

If a destination has a non-empty `AGENTS.override.md`, that file is the effective instruction source at the same scope; create a separate backup and merge deliberately instead of creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge only the relevant sections while preserving existing personal or project-specific constraints. Do not blindly replace an existing global file. The templates contain opinionated defaults for role, language behavior, reasoning depth, authorization, and delivery discipline; adapt them to the user, team, and repository. The English global template is language-neutral, while the `zh-CN/` template intentionally defaults to Simplified Chinese.

Codex loads the global and applicable project `AGENTS.md` chain independently of Skill selection. The global v7.7 template therefore keeps truthfulness, response modes, context health, execution efficiency and context hygiene, pre-output review, output rules, evidence-state boundaries, no-change legitimacy, bounded implementation discipline, existing-behavior and instruction-surface protection, validation-failure attribution, and a compact RD delivery baseline active even when no RD Skill is selected; a matching Skill adds the full specialist workflow rather than supplying the only copy of these controls.

Codex discovers the instruction chain once at the start of each run. At a given level, a non-empty `AGENTS.override.md` takes precedence over `AGENTS.md`; global guidance is loaded before project files from the repository root toward the working directory, so closer project guidance has higher precedence. Loading stops at `project_doc_max_bytes`, and changed instructions require a new run or session to take effect. See the official OpenAI documentation for [custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

## Skills

Global install:

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R skills/rd-* "$skill_target/"
```

On PowerShell, the preferred user-level installation is the verified installer:

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language en
pwsh -File ./scripts/install-rd-skills.ps1 -Language en -CheckOnly
```

The installer manages only the nine declared `rd-*` directories, verifies a SHA-256 backup under `$HOME/.agents/backups`, stages and verifies the replacement, restores the previous installation if replacement fails, and then compares every installed file with the selected source tree. `-CheckOnly` performs the final comparison without writing.

Project-level install:

```bash
skill_target="/path/to/your-project/.agents/skills"
mkdir -p "$skill_target"
for skill_source in skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R skills/rd-* "$skill_target/"
```

## Codex Configuration

Start from the safe example:

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -e "$codex_home/config.toml" ]; then
  cp codex/examples/config.example.toml "$codex_home/config.toml"
fi
```

If `$CODEX_HOME/config.toml` already exists (default: `~/.codex/config.toml`), merge only the relevant sections.

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

On Windows, user-level environment variables can also be set with `setx`, but restart your shell and any affected client—Codex CLI, Codex app, Cursor, or Claude Code—after changing them.

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
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

If a non-empty `AGENTS.override.md` exists at either scope, back up and merge that effective file rather than creating an inactive `AGENTS.md`. If `AGENTS.md` already exists, back it up and merge manually. Do not use the translation pack to overwrite personal or repository-specific rules.

Install Chinese shared skills:

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
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
