# Claude Code Adapter

The primary target of this repository is Codex. Claude Code support is provided as an adapter layer using Claude Code's native files.

This adapter follows Anthropic's documented Claude Code carriers for [memory](https://docs.anthropic.com/en/docs/claude-code/memory), [settings](https://docs.anthropic.com/en/docs/claude-code/settings), and [skills](https://docs.anthropic.com/en/docs/claude-code/skills).

## Current Status

The available Claude Code adapter is currently packaged under:

```text
claude/
  global/CLAUDE.md
  project/CLAUDE.md
  project/.claude/settings.json
  project/.claude/skills/rd-*/SKILL.md
```

This adapter maps the same three-layer delivery model to Claude Code:

- `global/CLAUDE.md`: user-level memory and behavior rules.
- `project/CLAUDE.md`: project-level engineering discipline.
- `project/.claude/settings.json`: conservative project settings.
- `project/.claude/skills/rd-*`: project-level R&D skills.

## Installation

Install user-level Claude Code memory:

```bash
cp claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

Install project-level Claude Code rules and skills:

```bash
cp claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r claude/project/.claude /path/to/your-project/.claude
```

If the destination files already exist, merge manually. Do not blindly overwrite existing Claude Code memory, settings, or skills.

## Public-Release Posture

For the first public release, treat Claude Code support as optional:

- Codex rules and skills remain the stable baseline.
- Claude Code files are included for compatibility and migration reference.
- Re-check Claude Code file conventions before changing `CLAUDE.md`, `.claude/settings.json`, or `.claude/skills/` behavior.
