# Cursor 三层交付体系适配包（zh-CN）

本目录是 Codex Three-Layer Delivery 的 Cursor 兼容适配包，面向中文使用场景。

## 当前状态

- `.cursor/rules/*.mdc`：按 Cursor 规则文件拆分的文档交付纪律。
- `.cursor/skills/rd-*/SKILL.md`：Cursor 版 `rd-*` 技能。
- `.cursor/mcp.example.json`：显式选择启用（opt-in）的 MCP 示例配置。
- `PROMPTS.md`：中文提示词模板。

## Cursor 官方文档基线

已于 2026-07-10 核查：

- [Rules](https://cursor.com/docs/context/rules)：项目规则位于 `.cursor/rules`，支持 `.md` 和 `.mdc`；`.mdc` frontmatter 可声明 `description`、`globs` 等元数据。
- [Skills](https://cursor.com/docs/skills)：Agent Skills 是可版本化的能力包，可包含脚本、模板和参考资料。
- [MCP](https://cursor.com/docs/context/mcp)：项目级 MCP 配置文件是 `.cursor/mcp.json`。

## 使用方式

将 `.cursor/` 目录复制到目标 Cursor 项目根目录：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
```

如果目标项目已经有 `.cursor/`，请手动合并，不要直接覆盖。

## 可选 MCP 配置

本目录不直接发布活动 `.cursor/mcp.json`，而是发布示例文件：

```text
cursor/zh-CN/.cursor/mcp.example.json
```

需要启用 MCP 时，先审查数据流、凭据和使用场景，再复制为目标项目的 `.cursor/mcp.json`：

```bash
cp cursor/zh-CN/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

不要假定 `disabled`、`alwaysAllow` 等字段属于 Cursor 官方稳定 MCP 配置面。本仓库的公开模板不依赖这些字段。

## 公开发布说明

此适配包保留中文内容。英文 Cursor 适配包（adapter）位于 `cursor/project/`；英文根目录仍是权威基线（canonical baseline）。
