# Compatibility

Version data in this file was checked on 2026-05-28. Re-check registry latest versions and tool/API surface before each public release.

## Codex

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.134.0` | `0.134.0` | Do not hardcode this into the repository name or AGENTS rules. Treat it as compatibility metadata. |

## Claude Code

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.153` | File conventions checked for `CLAUDE.md`, `.claude/settings.json`, and `.claude/skills/`. Re-check before changing adapter behavior. |

Official Claude Code docs checked: [memory](https://docs.anthropic.com/en/docs/claude-code/memory), [settings](https://docs.anthropic.com/en/docs/claude-code/settings), and [skills](https://docs.anthropic.com/en/docs/claude-code/skills).

## MCP Packages

| MCP server | Package | Tested/pinned version | Registry latest checked | Default in public config |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `2.3.0` | `3.0.0` | disabled until credentials are configured |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.19` | disabled until credentials are configured |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2025.12.18` | disabled |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.0.82` | disabled |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.75` | disabled |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.1.1` | disabled |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | disabled |

Context7 remains pinned to `2.3.0` until `3.0.0` tool names, authentication behavior, and Codex/Cursor/Claude Code config compatibility are re-verified.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested/pinned versions and config examples only after re-verification;
4. keep the config examples pinned to tested versions;
5. do not replace pinned versions with `@latest`;
6. document any tool-name or API-surface changes in the release notes.
