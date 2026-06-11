# 兼容性

本文件中的版本数据于 2026-05-28 核查。Cursor 适配包文档于 2026-05-29 核查。每次公开发布前都应重新核查 registry 最新版本和工具/API surface（API 表面，即可调用接口和行为）。

## Codex

| 组件 | 已测试 / 已固定版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@openai/codex` npm 包 | `0.134.0` | `0.134.0` | 不要把该版本写进仓库名或 AGENTS 规则；它只是兼容性元数据。 |

## Claude Code

| 组件 | 已测试 / 已固定版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm 包 | 本仓库不固定 | `2.1.153` | 已核查 `CLAUDE.md`、`.claude/settings.json`、`.claude/skills/` 文件约定。变更适配行为前需重新核查。 |

Claude Code 官方文档核查入口：

- https://docs.anthropic.com/en/docs/claude-code/memory
- https://docs.anthropic.com/en/docs/claude-code/settings
- https://docs.anthropic.com/en/docs/claude-code/skills

## Cursor

Cursor 官方文档于 2026-05-29 核查：

- [Rules](https://cursor.com/docs/context/rules)：项目规则位于 `.cursor/rules`，支持 `.md` 和 `.mdc`；`.mdc` frontmatter 可声明 `description`、`globs` 等元数据。
- [Skills](https://cursor.com/docs/skills)：Agent Skills 是可版本化的能力包，可包含脚本、模板和参考资料。
- [MCP](https://cursor.com/docs/context/mcp)：项目级 MCP 服务器通过 `.cursor/mcp.json` 配置。

| 适配面 | 仓库路径 | 公开发布姿态 |
|---|---|---|
| 英文规则 | `cursor/project/.cursor/rules/*.mdc` | Cursor 原生项目规则 |
| 英文 Skills | `cursor/project/.cursor/skills/rd-*/SKILL.md` | 与根目录 `skills/rd-*` 镜像 |
| 英文 MCP 示例 | `cursor/project/.cursor/mcp.example.json` | 仅示例；审查后复制为 `.cursor/mcp.json` |
| 中文规则 | `cursor/zh-CN/.cursor/rules/*.mdc` | Cursor 平台专用中文兼容包 |
| 中文 Skills | `cursor/zh-CN/.cursor/skills/rd-*/SKILL.md` | 与 `zh-CN/skills/rd-*` 镜像 |
| 中文 MCP 示例 | `cursor/zh-CN/.cursor/mcp.example.json` | 仅示例；审查后复制为 `.cursor/mcp.json` |

本仓库不直接发布活动 Cursor `.cursor/mcp.json`，也不在公开模板中依赖 `disabled` 或 `alwaysAllow` 等未确认的 Cursor MCP 字段。

## MCP 包

| MCP 服务器 | 包名 | 已测试 / 已固定版本 | registry 最新核查版本 | 公开配置默认值 |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `2.3.0` | `3.0.0` | 凭据配置前禁用 |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.19` | 凭据配置前禁用 |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2025.12.18` | 禁用 |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.0.82` | 禁用 |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.75` | 禁用 |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.1.1` | 禁用 |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | 禁用 |

Context7 继续固定在 `2.3.0`，直到 `3.0.0` 的工具名、认证行为以及 Codex/Cursor/Claude Code 配置兼容性重新验证完成。

## 发布规则

创建 tag 前：

1. 对每个 npm MCP 包运行 `npm view <package> version`；
2. 如果版本变化，更新 `registry latest`（注册表最新版本）列；
3. 只有重新验证后，才更新已测试 / 已固定版本和配置示例；
4. 配置示例必须固定到已测试版本；
5. 不要把固定版本替换为 `@latest`；
6. 工具名或 API surface 有变化时，在 release notes（发布说明）中说明。
