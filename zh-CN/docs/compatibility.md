# 兼容性

本文件中的版本数据于 2026-05-28 核查。每次公开发布前都应重新核查 registry 最新版本和工具/API surface（API 表面，即可调用接口和行为）。

## Codex

| 组件 | 已测试 / 已 pin 版本 | registry latest checked | 备注 |
|---|---:|---:|---|
| `@openai/codex` npm 包 | `0.134.0` | `0.134.0` | 不要把该版本写进仓库名或 AGENTS 规则；它只是兼容性元数据。 |

## Claude Code

| 组件 | 已测试 / 已 pin 版本 | registry latest checked | 备注 |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm 包 | 本仓库不 pin | `2.1.153` | 已核查 `CLAUDE.md`、`.claude/settings.json`、`.claude/skills/` 文件约定。变更适配行为前需重新核查。 |

Claude Code 官方文档核查入口：

- https://docs.anthropic.com/en/docs/claude-code/memory
- https://docs.anthropic.com/en/docs/claude-code/settings
- https://docs.anthropic.com/en/docs/claude-code/skills

## MCP Packages

| MCP server | Package | 已测试 / 已 pin 版本 | registry latest checked | 公开配置默认值 |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `2.3.0` | `3.0.0` | 凭据配置前禁用 |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.19` | 凭据配置前禁用 |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2025.12.18` | 禁用 |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.0.82` | 禁用 |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.75` | 禁用 |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.1.1` | 禁用 |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | 禁用 |

Context7 继续 pin 在 `2.3.0`，直到 `3.0.0` 的工具名、认证行为以及 Codex/Cursor/Claude Code 配置兼容性重新验证完成。

## 发布规则

打 tag 前：

1. 对每个 npm MCP package 运行 `npm view <package> version`；
2. 如果版本变化，更新 registry latest 列；
3. 只有重新验证后，才更新 tested/pinned version 和配置示例；
4. 配置示例必须 pin 到已测试版本；
5. 不要把 pin 版本替换为 `@latest`；
6. 工具名或 API surface 有变化时，在 release notes 中说明。
