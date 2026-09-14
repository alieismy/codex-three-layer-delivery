# 兼容性

本文件中的 Codex 和 Claude Code 包版本基线仍以 2026-09-07 的记录为准。Cursor 官方文档和已安装版本已于 2026-09-11 重新核查；下文 Claude Code 官方文档的详细检查仍以 2026-09-04 的记录为准，本机 Context7 有边界的 stdio 探针仍以 2026-08-14 的记录为准。每次公开发布前都应重新核查 registry 最新版本和工具/API surface（API 表面，即可调用接口和行为）。

## Codex

| 组件 | 已测试版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@openai/codex` npm 包 | `0.147.0` | `0.153.4` | 已于 2026-09-07 重新核查 registry 最新版本和本机 CLI（`0.153.4`）。tag 固定的 `0.153.4` Schema、实时 Schema 与此前 `0.153.2` 快照逐字节一致；四份示例均通过固定/实时 Schema 和隔离 strict-load（严格加载）检查。更广的测试基线仍为 `0.147.0`。不要把该版本写进仓库名或 AGENTS 规则。 |

仓库在 `schemas/` 下保存带来源和 SHA-256 元数据的 Codex `0.153.4` 配置 Schema 离线快照。`scripts/validate.ps1` 确定性使用该快照；仅发布前执行的 `scripts/validate-release.ps1` 会将其与当前官方 Schema 比较，核对已安装 CLI 版本，使用实时副本验证四份示例，并从隔离的临时 `CODEX_HOME` 严格加载每份示例。

## Claude Code

| 组件 | 已测试 / 已固定版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm 包 | 本仓库不固定 | `2.1.263` | 已于 2026-09-07 观察到 registry 最新版本和本机 CLI 均为 `2.1.263`；settings Schema、适配器结构和 `claude doctor` 最近一次使用 `2.1.260` 重新核查的日期仍为 2026-09-04。未实际执行危险命令验证权限行为；settings 校验不能证明所有包装命令或复合命令都会被拦截。 |

Claude Code 官方文档核查入口：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/skills

## Cursor

Cursor 官方文档已于 2026-09-11 重新核查；2026-09-11 观察到的本机 Windows 桌面版本为 `3.20.10`（system setup）：

- [Rules](https://cursor.com/docs/rules.md)：项目规则必须是 `.cursor/rules` 下的 `.mdc` 文件；规则系统会忽略普通 `.md` 文件。需要普通 Markdown 指令时，应使用 `AGENTS.md`。
- [Skills](https://cursor.com/docs/skills.md)：Agent Skills 是可版本化的能力包，可包含脚本、模板和参考资料。Cursor 会从 `.agents/skills/`、`.cursor/skills/`、`~/.agents/skills/` 和 `~/.cursor/skills/` 发现项目级和用户级 Skill，并按官方文档加载 Claude 与 Codex 兼容目录。官方文档没有定义多个目录发现同名 Skill 时的优先级。
- [MCP](https://cursor.com/docs/mcp.md)：项目级 MCP 服务器通过 `.cursor/mcp.json` 配置，全局 MCP 服务器使用 `~/.cursor/mcp.json`。

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
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.0.5` | Codex 示例禁用；Cursor 最小示例唯一 server，复制并配置凭据前不活动 |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | Codex 示例禁用；Cursor 最小示例省略 |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2026.8.31` | 公共最小示例省略 |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.3` | 公共最小示例省略 |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.80` | Codex 示例禁用；Cursor 最小示例省略 |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.8.0` | Codex 示例禁用；Cursor 最小示例省略 |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | 公共最小示例省略 |

Context7 `4.0.2` 已对照 [npm 包元数据](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2)和 2026-08-11 发布的 [GitHub 官方 Release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2)核实。该包要求 Node.js `>=20.18.1`。在 Windows 与 Node.js `24.18.0` 环境中，包能够返回预期 CLI 版本与参数，完成 MCP 协议 `2025-06-18` 的 stdio `initialize` 交换，并通过 `tools/list` 返回 `resolve-library-id` 和 `query-docs`。

上述结果只构成包、静态配置和 stdio 协议层证据，不证明已完成 Context7 鉴权查询、Codex/Cursor/Claude Code 宿主端到端集成或业务/生产验收。达到更高证据层级前，不得作相应成功声明。

Codex 配置示例只固定 Context7，其它 npm MCP 调用有意不固定版本。Cursor 最小示例也只包含已测试的 Context7 固定版本。其它 server 仍可按 `docs/mcp-routing.md` 路由，但应在存在已验证需求时逐项添加，不应把完整候选目录一次复制进配置。上表版本仍作为兼容性证据，发布前必须重新核查。

## 发布规则

创建 tag 前：

1. 对每个 npm MCP 包运行 `npm view <package> version`；
2. 如果版本变化，更新 `registry latest`（注册表最新版本）列；
3. 只有重新验证后，才更新已测试版本；
4. 所有 Codex/Cursor Context7 示例必须与本表已测试版本一致；`scripts/validate.ps1` 会强制检查这一跨文件不变量；
5. 其它 Codex npm MCP 示例不固定版本，也不显式添加 `@latest` 后缀；
6. 运行 `pwsh ./scripts/validate-release.ps1`，检测 Codex 官方 Schema 漂移，并使用版本匹配的已安装 CLI 严格加载示例；
7. 工具名或 API surface 有变化时，在 release notes（发布说明）中说明。
