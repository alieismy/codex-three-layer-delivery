# Claude Code Adapter

The primary target of this repository is Codex. Claude Code support is provided as an adapter layer using Claude Code's native files.

This adapter follows Anthropic's Claude Code documentation for [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills), checked on 2026-08-24.

## Current Status

The available Claude Code adapter is currently packaged under:

```text
claude/
  global/CLAUDE.md
  project/CLAUDE.md
  project/.claude/settings.json
  project/.claude/skills/rd-*/
    SKILL.md
    evals/*.json
    references/*.md  # when required
```

This adapter maps the same document-delivery three-layer model to Claude Code:

- `global/CLAUDE.md`: user-level memory and behavior rules.
- `project/CLAUDE.md`: project-level document-delivery discipline.
- `project/.claude/settings.json`: conservative project settings.
- `project/.claude/skills/rd-*`: project-level document-delivery skills.

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
