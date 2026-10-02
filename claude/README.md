# Claude Code Adapter

The primary target of this repository is Codex. Claude Code support is provided as an adapter layer using Claude Code's native files.

This adapter follows Anthropic's Claude Code documentation for [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills), re-checked on 2026-09-04; the memory page was re-checked on 2026-10-01 for `AGENTS.md` support.

## Current Status

The available Claude Code adapter is currently packaged under:

```text
claude/
  global/CLAUDE.md
  project/CLAUDE.md          # thin adapter: @AGENTS.md + Claude Code-specific guidance
  project/.claude/settings.json
  project/.claude/skills/rd-*/
    SKILL.md
    evals/*.json
    references/*.md  # when required
```

This adapter maps the same document-delivery three-layer model to Claude Code:

- `global/CLAUDE.md`: user-level memory and behavior rules.
- `project/CLAUDE.md`: thin project adapter that imports the shared project core (`codex/project/AGENTS.md`, installed as the project `AGENTS.md`).
- `project/.claude/settings.json`: guardrail-oriented settings that deny common secret-file reads at any depth under the working directory and ask before matching Bash or Windows PowerShell commit, push, tag, publish, delete, and uncommitted-work-discarding Git command prefixes (`reset --hard`, `clean`, `checkout --`, `restore`). Read deny rules also block built-in Edit on the same paths from v2.1.208 and Write from v2.1.228. NotebookEdit is not covered; use an Edit deny rule for paths no built-in tool may change. These rules do not stop arbitrary scripts that open files themselves, and Windows has no Claude Code sandbox.
- `project/.claude/skills/rd-*`: project-level document-delivery skills.

## Installation

Install user-level Claude Code memory:

```bash
cp claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

Install the shared project core and the Claude Code project adapter. If the target already has `AGENTS.md` (for example from the Codex installation), keep it and merge instead of overwriting:

```bash
(
if [ -s /path/to/your-project/AGENTS.override.md ]; then
  printf '%s\n' 'Stop: merge the effective override and select the Claude import target manually before installing.' >&2
  exit 1
fi
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
cp claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r claude/project/.claude /path/to/your-project/.claude
)
```

If the destination files already exist, merge manually. Do not blindly overwrite existing Claude Code memory, settings, or skills.

If a non-empty `AGENTS.override.md` exists, the recipe stops before installing the adapter. Merge that effective Codex source deliberately and select the matching Claude import (for example `@AGENTS.override.md`) before continuing; Claude does not discover override files automatically. An existing empty `AGENTS.md` also requires manual repair.

Bash project installation runs in a subshell; guard failures leave the parent interactive shell available. Windows users can use the [native PowerShell recipe](../docs/installation.md#windows-powershell-project-installation).

## Shared Project Core

`project/CLAUDE.md` is a thin adapter. Its `@AGENTS.md` line imports the shared project core from `codex/project/AGENTS.md`; the rest contains only Claude Code-specific guidance. Change project-wide behavior in `codex/project/AGENTS.md`, not in the adapter.

Claude Code v2.1.277 and later can read `AGENTS.md` directly, but only when no `CLAUDE.md` is present. Because this adapter ships a `CLAUDE.md`, the explicit import keeps `AGENTS.md` loaded; it also works on earlier versions and never loads the file twice ([memory documentation](https://code.claude.com/docs/en/memory#agents-md), checked 2026-10-01). Use the import rather than a symlink on Windows. Run `/memory` or `/context` in a new session to confirm that both files loaded.

The import shares textual instructions only; it does not replace Claude Code settings, permissions, hooks, Skill discovery, or other platform controls. Imported content still consumes context. Cursor also reads both `AGENTS.md` and `CLAUDE.md`; review that combination before using both adapters together.

## Public-Release Posture

For the first public release, treat Claude Code support as optional:

- Codex rules and skills remain the stable baseline.
- Claude Code files are included for compatibility and migration reference.
- Re-check Claude Code file conventions before changing `CLAUDE.md`, `.claude/settings.json`, or `.claude/skills/` behavior.
