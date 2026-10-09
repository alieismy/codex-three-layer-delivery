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
(
set -e
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp claude/global/CLAUDE.md ~/.claude/CLAUDE.md
)
```

Install the shared project core and the Claude Code project adapter. If the target already has `AGENTS.md` (for example from the Codex installation), keep it and merge instead of overwriting:

```bash
(
set -e
if [ -e /path/to/your-project/CLAUDE.md ] || [ -L /path/to/your-project/CLAUDE.md ] || [ -e /path/to/your-project/.claude ] || [ -L /path/to/your-project/.claude ]; then
  printf '%s\n' 'Stop: merge existing Claude project files manually before installing.' >&2
  exit 1
fi
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

## claude.ai Skill Upload

Use this path when the RD Skills should follow your Claude account into claude.ai chat, Cowork, and Claude Code instead of being installed per project. Uploaded Skills are saved to the account; Claude Code signed in with that account downloads them to `~/.claude/skills/synced/` as `anthropic-skills:rd-*` ([Claude Code skills](https://code.claude.com/docs/en/skills), checked 2026-10-09).

```powershell
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language en            # all nine archives
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language en -Changed   # only Skills missing from or different on claude.ai
```

- The script packages the selected language's Claude adapter Skills into `.tmp/local/claude-ai-skills/<language>/rd-*.zip` (ignored, reproducible scratch output): one archive per Skill, with the Skill folder at the archive root as claude.ai requires ([Create custom skills](https://claude.com/docs/skills/how-to)). It omits `evals/` and `agents/`, which hold repository test definitions and Codex metadata. `manifest.json` records the source commit and archive hashes.
- It refuses uncommitted changes under the source tree so each upload maps to a commit; pass `-AllowDirty` for a trial package.
- `-Changed` compares the runtime payload with the copies Claude Code last synced, so Claude Code must be signed in with the same account with skill sync on. claude.ai rewrites the `SKILL.md` frontmatter layout on upload, so the comparison checks `name` and `description` by value and everything else byte for byte. Pass `-SyncedRoot` when more than one synced account directory exists.
- Upload each archive from **Customize > Skills**: select **+**, then **Create skill > Upload a skill**. Keep one copy per Skill: the claude.ai documentation does not say whether uploading an existing name replaces it, so remove or replace the older copy. After the next sync, rerun with `-Changed`; "nothing to upload" confirms that the synced copies match the source.
- Keep one source per environment. A project `.claude/skills/rd-*` or personal `~/.claude/skills/rd-*` copy does not hide the synced Skill: both load, the local copy takes `/rd-*`, and the synced copy remains available as `/anthropic-skills:rd-*`. When using uploaded Skills, install the project adapter without `.claude/skills/`.

## Public-Release Posture

For the first public release, treat Claude Code support as optional:

- Codex rules and skills remain the stable baseline.
- Claude Code files are included for compatibility and migration reference.
- Re-check Claude Code file conventions before changing `CLAUDE.md`, `.claude/settings.json`, or `.claude/skills/` behavior.
