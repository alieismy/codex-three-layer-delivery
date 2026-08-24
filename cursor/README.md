# Cursor Adapter

The primary target of this repository is Codex. Cursor support is provided as an adapter layer that maps the same document-delivery discipline into Cursor-native rules, skills, and optional MCP configuration.

## Current Status

The English Cursor adapter is packaged under:

```text
cursor/project/
  .cursor/rules/*.mdc
  .cursor/skills/rd-*/SKILL.md
  .cursor/mcp.example.json
  PROMPTS.md
```

The Simplified Chinese Cursor compatibility pack is packaged under:

```text
cursor/zh-CN/
  .cursor/rules/*.mdc
  .cursor/skills/rd-*/SKILL.md
  .cursor/mcp.example.json
  PROMPTS.md
  README.md
```

## Cursor Documentation Baseline

Cursor documentation checked on 2026-08-24:

- [Rules](https://cursor.com/docs/rules): Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance.
- [Skills](https://cursor.com/docs/skills): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references.
- [MCP](https://cursor.com/docs/context/mcp): project-specific MCP servers are configured through `.cursor/mcp.json`.

## Recommended Public-Release Posture

Treat Cursor support as optional and explicitly opt-in:

- Codex document rules and skills are the stable baseline.
- `cursor/project/` is the English Cursor adapter.
- `cursor/zh-CN/` remains the Cursor-specific Simplified Chinese compatibility pack.
- This repository ships `mcp.example.json`, not an active `.cursor/mcp.json`.
- Do not rely on undocumented Cursor MCP fields such as `disabled` or `alwaysAllow` in public templates.

## Installation

Install the English adapter:

```bash
if [ ! -e /path/to/your-project/.cursor ]; then
  cp -r cursor/project/.cursor /path/to/your-project/.cursor
fi
if [ ! -e /path/to/your-project/PROMPTS.cursor.md ]; then
  cp cursor/project/PROMPTS.md /path/to/your-project/PROMPTS.cursor.md
fi
```

Install the Simplified Chinese Cursor pack:

```bash
if [ ! -e /path/to/your-project/.cursor ]; then
  cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
fi
if [ ! -e /path/to/your-project/PROMPTS.cursor.zh-CN.md ]; then
  cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
fi
```

If the target workspace already has `.cursor/` or either prompt destination, back it up and merge manually.

## Optional MCP Setup

The adapter ships MCP as an explicit example file:

```text
cursor/project/.cursor/mcp.example.json
cursor/zh-CN/.cursor/mcp.example.json
```

To enable MCP in a target Cursor workspace, review the data flow and credentials first, then copy the example:

```bash
cp cursor/project/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

Fill only the environment variables for servers you actually enable. Context7 reads `CONTEXT7_API_KEY` from the environment through `envFile`; do not place the key in command arguments. Re-check Cursor's MCP status in the UI after copying.
