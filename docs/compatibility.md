# Compatibility

Package registry versions and the installed Codex CLI were re-checked on 2026-08-18. The bounded local Context7 stdio probe remains dated 2026-08-14. Re-check registry latest versions and tool/API surfaces before each public release.

## Codex

| Component | Tested version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.147.0` | `0.147.0` | Installed CLI and registry version re-checked on 2026-08-18; configuration examples remain validated for `0.147.0`. Do not hardcode this into the repository name or AGENTS rules. |

## Claude Code

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.234` | File conventions checked for `CLAUDE.md`, `.claude/settings.json`, and `.claude/skills/` on 2026-07-10. Re-check before changing adapter behavior. |

Official Claude Code docs checked: [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), and [skills](https://code.claude.com/docs/en/skills).

## Cursor

Official Cursor docs checked on 2026-07-10:

- [Rules](https://cursor.com/docs/context/rules): Project Rules live in `.cursor/rules`; `.md` and `.mdc` are supported; `.mdc` frontmatter can specify metadata such as `description` and `globs`.
- [Skills](https://cursor.com/docs/skills): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references.
- [MCP](https://cursor.com/docs/context/mcp): project-specific MCP servers are configured through `.cursor/mcp.json`.

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
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.0.2` | disabled until credentials are configured |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | disabled until credentials are configured |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2026.7.4` | disabled |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.0` | disabled |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.79` | disabled |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.7.0` | disabled |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | disabled |

Context7 `4.0.2` was verified against the [npm package metadata](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2) and the [official GitHub release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2) published on 2026-08-11. The package requires Node.js `>=20.18.1`. On Windows with Node.js `24.18.0`, the package reported the expected CLI version and options, completed a stdio `initialize` exchange for MCP protocol `2025-06-18`, and returned `resolve-library-id` and `query-docs` from `tools/list`.

This is package, static-configuration, and stdio-protocol evidence. It does not prove authenticated Context7 queries, real Codex/Cursor/Claude Code host integration, or business/production acceptance. Those higher evidence layers must be tested in the target client before being claimed.

The Codex config examples pin only Context7. Other npm MCP package invocations in those Codex examples are intentionally unpinned; Cursor examples retain their documented package pins. The versions above remain compatibility evidence and must be re-checked before release.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested versions only after re-verification;
4. keep every Context7 Codex/Cursor example pinned to the tested version in this table; `scripts/validate.ps1` enforces the cross-file invariant;
5. leave other Codex npm MCP examples unpinned and do not add an explicit `@latest` suffix;
6. document any tool-name or API-surface changes in the release notes.
