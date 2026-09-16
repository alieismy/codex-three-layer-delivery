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

The Cursor Rules and Skills documentation was re-checked on 2026-09-16. The MCP documentation and the installed Windows desktop version (`3.20.10`, system setup) retain their 2026-09-11 check and observation:

- [Rules](https://cursor.com/docs/rules.md): Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance.
- [Skills](https://cursor.com/docs/skills.md): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references.
- [MCP](https://cursor.com/docs/mcp.md): project-specific MCP servers are configured through `.cursor/mcp.json`.

## Recommended Public-Release Posture

Treat Cursor support as optional and explicitly opt-in:

- Codex document rules and skills are the stable baseline.
- `cursor/project/` is the English Cursor adapter.
- `cursor/zh-CN/` remains the Cursor-specific Simplified Chinese compatibility pack.
- Only `00-global-principles.mdc` is always-on; the other nine Project Rules use trigger-first descriptions and load on demand.
- This repository ships `mcp.example.json`, not an active `.cursor/mcp.json`.
- Do not rely on undocumented Cursor MCP fields such as `disabled` or `alwaysAllow` in public templates.

## Installing Alongside Other Adapters

Cursor discovers Skills from `.agents/skills/`, `.cursor/skills/`, `~/.agents/skills/`, and `~/.cursor/skills/`, plus the compatible `.claude/skills/`, `.codex/skills/`, `~/.claude/skills/`, and `~/.codex/skills/` roots ([Cursor Skills](https://cursor.com/docs/skills.md)). The documentation does not define precedence or deduplication for the same Skill name found in more than one root. Before installing this adapter, inventory every discovered root. Choosing only one project adapter does not eliminate same-name definitions already present in user-level roots.

A normal shared/Codex installation under `~/.agents/skills/` or project `.agents/skills/` combined with this adapter's `.cursor/skills/` already creates multiple discoverable definitions with the same `rd-*` names; Claude Code is not required for that conflict. Do not resolve it by blindly omitting the Cursor Skill tree: the Cursor `rd-delivery` mirror carries the platform-specific `disable-model-invocation: true` guard, while Codex enforces the same explicit-only policy through `agents/openai.yaml`. This repository does not yet document a runtime-verified, general-purpose installation recipe that both removes same-name ambiguity and preserves every client's platform-specific invocation contract. For Cursor-only use, ensure that the Cursor copy is the sole discoverable definition of each `rd-*` Skill in that environment. If Cursor must share the environment with Codex or Claude Code, preserve the platform-specific copies, verify which definition Cursor selects and whether `rd-delivery` remains explicit-only in a fresh session, and record the accepted arrangement. Remove or relocate an existing Skill copy only with authorization appropriate to its scope.

Installing the Claude Code adapter also adds `.claude/skills/` and a project `CLAUDE.md`. Cursor reads `CLAUDE.md` the same way it reads `AGENTS.md`, and applies it to every conversation regardless of any `alwaysApply` setting ([Cursor rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor), checked 2026-09-16). Review both the same-name Skill sources and the always-on instruction files before combining adapters; do not call them deduplicated until the target Cursor runtime has been verified.

Cursor supports nested `AGENTS.md` files and documents that they apply when working with files in their directory or descendants, with more-specific instructions taking precedence ([Cursor rules](https://cursor.com/docs/rules.md)). Adapter copies kept under nested source directories can therefore conflict with repository-maintainer guidance for work in those subtrees; do not assume a root instruction file overrides them.

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

The adapter ships a minimal, explicit MCP example containing only Context7:

```text
cursor/project/.cursor/mcp.example.json
cursor/zh-CN/.cursor/mcp.example.json
```

To enable MCP in a target Cursor workspace, review the data flow and credentials first, then copy the example:

```bash
cp cursor/project/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

Set `CONTEXT7_API_KEY` in the host environment. The example maps exactly one API key into the credentialed server through its own `env` object; do not replace this mapping with a shared `envFile` or place the key in command arguments. Restart Cursor after changing host environment variables, then re-check MCP status in the UI.

Add other servers one at a time only for a verified use case. `docs/mcp-routing.md` is a routing guide, not a configuration catalog to copy wholesale.
