# 安装说明

本仓库提供模板。请把模板合并进你的本地 Codex、Claude Code 或项目配置，不要盲目覆盖已有文件。

## Codex 规则

安装全局规则：

```bash
cp zh-CN/codex/global/AGENTS.md ~/.codex/AGENTS.md
```

安装项目规则：

```bash
cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

如果目标项目已有 `AGENTS.md`，请手动合并并保留项目特定约束。

## Codex Skills

全局安装：

```bash
cp -r zh-CN/skills/rd-* ~/.agents/skills/
```

项目级安装：

```bash
mkdir -p /path/to/your-project/.agents/skills
cp -r zh-CN/skills/rd-* /path/to/your-project/.agents/skills/
```

## Codex 配置

从安全示例开始：

```bash
cp zh-CN/codex/examples/config.example.toml ~/.codex/config.toml
```

如果已有配置，只合并需要的片段。

高权限配置档需要显式选择：

```text
zh-CN/codex/examples/config.full-access.example.toml
```

不要在不可信仓库中使用 full access（完全访问权限）。

## Claude Code 适配包

安装用户级 Claude Code memory：

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

安装项目级 Claude Code 规则和 Skills：

```bash
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

如果目标项目已有 `CLAUDE.md` 或 `.claude/`，请手动合并。

## Cursor 适配包

安装 Cursor 英文适配包：

```bash
cp -r cursor/project/.cursor /path/to/your-project/.cursor
cp cursor/project/PROMPTS.md /path/to/your-project/PROMPTS.cursor.md
```

Cursor 中文适配包保留在：

```text
cursor/zh-CN/
```

复制 `.cursor` 目录到 Cursor 工作区：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
```

如果目标项目已有 `.cursor/`，请手动合并。

Cursor MCP 需要显式启用。先审查凭据、数据流和使用场景，再把示例文件复制为目标项目的 `.cursor/mcp.json`：

```bash
cp cursor/zh-CN/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

## 环境变量

复制环境变量示例：

```bash
cp .env.example .env
```

只填写你实际启用的 MCP 服务器所需 API key。不要提交 `.env`。

Windows 用户级环境变量也可用 `setx` 设置，但设置后需要重启 shell、Codex CLI、Codex App、Cursor 或 Claude Code。
