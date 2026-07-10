# Compatibility

Version data and current Skills documentation were re-checked on 2026-07-10. Re-check registry latest versions and tool/API surfaces before each public release.

## Codex

| Component | Tested version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.144.1` | `0.144.1` | Config reference and examples re-verified on 2026-07-10. Do not hardcode this into the repository name or AGENTS rules. |

## Claude Code

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.206` | File conventions checked for `CLAUDE.md`, `.claude/settings.json`, and `.claude/skills/` on 2026-07-10. Re-check before changing adapter behavior. |

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
| Context7 | `@upstash/context7-mcp` | `2.3.0` | `3.0.0` | disabled until credentials are configured |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.19` | disabled until credentials are configured |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2025.12.18` | disabled |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.0.82` | disabled |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.75` | disabled |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.1.1` | disabled |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | disabled |

Context7 remains pinned to `2.3.0` until `3.0.0` tool names, authentication behavior, and Codex/Cursor/Claude Code config compatibility are re-verified.

The Codex config examples pin only Context7. Other npm MCP package invocations are intentionally unpinned; the versions above remain compatibility evidence and must be re-checked before release.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested versions only after re-verification;
4. keep Context7 pinned to the tested `2.3.0` version until its compatibility decision is reopened;
5. leave other Codex npm MCP examples unpinned and do not add an explicit `@latest` suffix;
6. document any tool-name or API-surface changes in the release notes.
