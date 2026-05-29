# MCP 路由

MCP 服务器应为具体证据或工作流需求启用，不应作为宽泛默认值。

## 路由表

| 需求 | 优先路径 | 备注 |
|---|---|---|
| 库、框架、SDK 文档 | Context7 | 需要官方文档或示例时启用。 |
| 当前 Web 研究 | Codex 内置 `web_search` 或 Tavily | 时效性事实必须使用当前来源。 |
| 复杂多方案推理 | 原生模型推理优先；Sequential Thinking 按需 | 只有明确需要推理轨迹工具时启用。 |
| 开源项目架构 | DeepWiki 按需 | 适用于公开 GitHub 项目。 |
| 独立搜索索引 | Brave Search 按需 | 需要 API key 和账号设置。 |
| 浏览器自动化和 E2E 测试 | Playwright CLI 或内置浏览器工具优先 | 只有 MCP 能明显改善工作流时启用 Playwright MCP。 |
| 前端网络 / 性能调试 | Chrome DevTools MCP 按需 | 默认禁用。 |
| 跨仓库代码分析 | Augment Context Engine 按需 | 不提交个人 relay URL。 |

## 公开模板规则

- npm MCP 命令中不要使用 `@latest`。
- 需要 API key 的 MCP 服务器在凭据配置前不要启用。
- 不硬编码私有 relay URL。
- 除非仓库明确记录数据流，否则外部服务默认禁用。
- 已验证包版本记录在 `docs/compatibility.md` 和 `zh-CN/docs/compatibility.md`。
