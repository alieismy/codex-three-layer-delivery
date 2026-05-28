# Cursor Adapter

The primary target of this repository is Codex. Cursor support is provided as an adapter layer.

## Current Status

The available Cursor adapter is currently packaged under:

```text
cursor/zh-CN/
  .cursor/rules/*.mdc
  .cursor/skills/rd-*/SKILL.md
  PROMPTS.md
  README.md
```

This adapter is a Chinese-language compatibility pack derived from the same three-layer delivery model.

## Recommended Public-Release Posture

For the first public release, treat Cursor support as optional:

- Codex rules and skills are the stable baseline.
- Cursor `zh-CN` files are included for compatibility and migration reference.
- A full English Cursor adapter should be released only after its `.mdc` rules, skills, prompts, and MCP config are translated and re-verified.

## Installation

Copy the packaged Cursor files into a Cursor workspace:

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
```

If the target workspace already has `.cursor/`, merge manually.
