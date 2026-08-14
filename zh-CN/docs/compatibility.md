# 兼容性

本文件中的包 registry 版本以及本机 Codex/Context7 探针已于 2026-08-14 重新核查。每次公开发布前都应重新核查 registry 最新版本和工具/API surface（API 表面，即可调用接口和行为）。

## Codex

| 组件 | 已测试版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@openai/codex` npm 包 | `0.147.0` | `0.147.0` | 已于 2026-08-14 重新核查本机 CLI 和配置示例；不要把该版本写进仓库名或 AGENTS 规则。 |

## Claude Code

| 组件 | 已测试 / 已固定版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm 包 | 本仓库不固定 | `2.1.232` | 已于 2026-07-10 核查 `CLAUDE.md`、`.claude/settings.json`、`.claude/skills/` 文件约定。变更适配行为前需重新核查。 |

Claude Code 官方文档核查入口：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/skills

## Cursor

Cursor 官方文档于 2026-07-10 核查：

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

| MCP 服务器 | 包名 | 已测试版本 | registry 最新核查版本 | 公开配置默认值 |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.0.2` | 凭据配置前禁用 |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | 凭据配置前禁用 |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2026.7.4` | 禁用 |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.0` | 禁用 |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.79` | 禁用 |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.7.0` | 禁用 |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | 禁用 |

Context7 `4.0.2` 已对照 [npm 包元数据](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2)和 2026-08-11 发布的 [GitHub 官方 Release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2)核实。该包要求 Node.js `>=20.18.1`。在 Windows 与 Node.js `24.18.0` 环境中，包能够返回预期 CLI 版本与参数，完成 MCP 协议 `2025-06-18` 的 stdio `initialize` 交换，并通过 `tools/list` 返回 `resolve-library-id` 和 `query-docs`。

上述结果只构成包、静态配置和 stdio 协议层证据，不证明已完成 Context7 鉴权查询、Codex/Cursor/Claude Code 宿主端到端集成或业务/生产验收。达到更高证据层级前，不得作相应成功声明。

Codex 配置示例只固定 Context7。其它 npm MCP 包调用有意不固定版本；上表版本仍作为兼容性证据，发布前必须重新核查。

## 发布规则

创建 tag 前：

1. 对每个 npm MCP 包运行 `npm view <package> version`；
2. 如果版本变化，更新 `registry latest`（注册表最新版本）列；
3. 只有重新验证后，才更新已测试版本；
4. 所有 Codex/Cursor Context7 示例必须与本表已测试版本一致；`scripts/validate.ps1` 会强制检查这一跨文件不变量；
5. 其它 Codex npm MCP 示例不固定版本，也不显式添加 `@latest` 后缀；
6. 工具名或 API surface 有变化时，在 release notes（发布说明）中说明。
