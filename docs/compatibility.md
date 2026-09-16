# Compatibility

The `@openai/codex`, `@anthropic-ai/claude-code`, and `@upstash/context7-mcp` registry latest versions were rechecked on 2026-09-16; the other MCP registry entries keep their earlier snapshot. The Codex package baseline was otherwise rechecked on 2026-09-14; the Claude Code package baseline remains dated 2026-09-07. The Cursor Rules, Skills, and FAQ documentation was rechecked on 2026-09-16; the installed Cursor version keeps its 2026-09-11 observation. The detailed Claude Code documentation check below remains dated 2026-09-04, and the bounded local Context7 stdio probe remains dated 2026-08-14. Re-check registry latest versions and tool/API surfaces before each public release.

## Codex

| Component | Tested version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.147.0` | `0.154.0` | Registry latest `0.154.0` was rechecked on 2026-09-16; the installed CLI `0.154.0` was last rechecked on 2026-09-14. The tagged `0.154.0` schema was fetched for this release baseline; the release gate compares it with the current live schema and runs the four example checks. The broader tested baseline remains `0.147.0`. Do not hardcode this into the repository name or AGENTS rules. |

The repository vendors the Codex `0.154.0` configuration schema as an offline snapshot with provenance and SHA-256 metadata under `schemas/`. `scripts/validate.ps1` uses the snapshot deterministically; the release-only `scripts/validate-release.ps1` compares it with the current official schema, checks the installed CLI version, validates all four examples against the live copy, and strict-loads each example from an isolated temporary `CODEX_HOME`.

## Claude Code

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.273` | Registry latest `2.1.273` was observed on 2026-09-16; the installed CLI `2.1.263` was observed on 2026-09-07. The settings schema, adapter structure, and `claude doctor` were last re-checked with `2.1.260` on 2026-09-04. Dangerous-command permission behavior was not exercised; settings validation is not proof that every wrapper or compound command will be intercepted. |

Official Claude Code docs checked: [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills).

## Cursor

The Cursor Rules, Skills, and FAQ documentation was rechecked on 2026-09-16; the installed Windows desktop version observed on 2026-09-11 was `3.20.10` (system setup):

- [Rules](https://cursor.com/docs/rules.md): Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance. Cursor supports nested `AGENTS.md` files, applies them when working with files in their directory or descendants, combines them with parent instructions, and gives more-specific instructions precedence.
- [Skills](https://cursor.com/docs/skills.md): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references. Cursor discovers project and user Skills from `.agents/skills/`, `.cursor/skills/`, `~/.agents/skills/`, and `~/.cursor/skills/`, and also loads `.claude/skills/`, `.codex/skills/`, `~/.claude/skills/`, and `~/.codex/skills/`. The official documentation does not define precedence or deduplication for same-name Skills found in multiple roots. A shared/Codex installation under an Agents root combined with the Cursor adapter's `.cursor/skills/` is already a multi-source installation even without Claude Code. The sources are not behaviorally interchangeable: the Cursor `rd-delivery` mirror uses `disable-model-invocation: true`, while the Codex source carries its explicit-only policy in `agents/openai.yaml`.
- [MCP](https://cursor.com/docs/mcp.md): project-specific MCP servers are configured through `.cursor/mcp.json`; global servers use `~/.cursor/mcp.json`.
- [Rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor) (checked 2026-09-16): Cursor reads `CLAUDE.md` the same way it reads `AGENTS.md`, and `CLAUDE.md` files are always applied to every conversation regardless of any `alwaysApply` frontmatter setting. Combining the Claude Code and Cursor adapters therefore adds another always-on instruction file as well as another discoverable Skill source; see `cursor/README.md`.

A 2026-09-16 maintainer session reported that the four distributable `AGENTS.md` templates under `codex/` and `zh-CN/codex/`, plus the English and Chinese Cursor `00-global-principles.mdc` files, were surfaced together as effective instructions. Those six files currently total 64,928 bytes and contain conflicting language directives. This is a single-session runtime observation, not an independently reproduced loading contract; the official nested-`AGENTS.md` documentation describes directory-scoped application instead. No isolation mechanism has been verified. Treat the observation as an unresolved source-repository compatibility risk, not proof that every Cursor session loads all six files or that the root maintainer file overrides them.

| Adapter surface | Repository path | Public-release posture |
|---|---|---|
| English rules | `cursor/project/.cursor/rules/*.mdc` | Cursor-native project rules |
| English skills | `cursor/project/.cursor/skills/rd-*/SKILL.md` | Mirrored from root `skills/rd-*` |
| English MCP example | `cursor/project/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |
| Chinese rules | `cursor/zh-CN/.cursor/rules/*.mdc` | Cursor-specific Simplified Chinese compatibility pack |
| Chinese skills | `cursor/zh-CN/.cursor/skills/rd-*/SKILL.md` | Mirrored from `zh-CN/skills/rd-*` |
| Chinese MCP example | `cursor/zh-CN/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |

This repository does not ship an active Cursor `.cursor/mcp.json` and does not rely on undocumented `disabled` or `alwaysAllow` fields in Cursor MCP templates.

## MCP Packages

| MCP server | Package | Tested version | Registry latest checked | Default in public config |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.1.1` | Codex example disabled; sole Cursor minimal example, inactive until copied and credentialed |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | Codex example disabled; omitted from Cursor minimal example |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2026.8.31` | Omitted from public minimal examples |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.3` | Omitted from public minimal examples |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.80` | Codex example disabled; omitted from Cursor minimal example |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.8.0` | Codex example disabled; omitted from Cursor minimal example |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | Omitted from public minimal examples |

Context7 `4.0.2` was verified against the [npm package metadata](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2) and the [official GitHub release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2) published on 2026-08-11. The package requires Node.js `>=20.18.1`. On Windows with Node.js `24.18.0`, the package reported the expected CLI version and options, completed a stdio `initialize` exchange for MCP protocol `2025-06-18`, and returned `resolve-library-id` and `query-docs` from `tools/list`.

This is package, static-configuration, and stdio-protocol evidence. It does not prove authenticated Context7 queries, real Codex/Cursor/Claude Code host integration, or business/production acceptance. Those higher evidence layers must be tested in the target client before being claimed.

The Codex config examples pin only Context7; their other npm MCP invocations are intentionally unpinned. The Cursor minimal example also contains only the tested Context7 pin. Other servers remain routing candidates in `docs/mcp-routing.md` and should be added one at a time for a verified need rather than copied as a full catalog. The versions above remain compatibility evidence and must be re-checked before release.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested versions only after re-verification;
4. keep every Context7 Codex/Cursor example pinned to the tested version in this table; `scripts/validate.ps1` enforces the cross-file invariant;
5. leave other Codex npm MCP examples unpinned and do not add an explicit `@latest` suffix;
6. run `pwsh ./scripts/validate-release.ps1` to detect official Codex schema drift and strict-load the examples with the matching installed CLI;
7. document any tool-name or API-surface changes in the release notes.
