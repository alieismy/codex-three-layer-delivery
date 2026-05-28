# Cursor 三层交付体系适配包（zh-CN）

本目录是 Codex Three-Layer Delivery 的 Cursor 兼容适配包，面向中文使用场景。

## 当前状态

- `.cursor/rules/*.mdc`：按 Cursor 规则文件拆分的工程纪律。
- `.cursor/skills/rd-*/SKILL.md`：Cursor 版 `rd-*` 技能。
- `.cursor/mcp.json`：公开安全默认的 MCP 示例配置。
- `PROMPTS.md`：中文提示词模板。

## 使用方式

将 `.cursor/` 目录复制到目标 Cursor 项目根目录：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
```

如果目标项目已经有 `.cursor/`，请手动合并，不要直接覆盖。

## 公开发布说明

此适配包保留中文内容。英文 Cursor adapter 尚未作为稳定入口发布；如果需要英文 Cursor 版本，应先完成 `.mdc` 规则、skills、prompts 和 MCP 配置的完整翻译与验证。
