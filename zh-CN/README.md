# Codex Three-Layer Delivery 简体中文包

本目录是 `Codex Three-Layer Delivery` 的简体中文 translation pack（翻译包）。英文根目录是 canonical baseline（权威基线）；本目录只提供中文阅读、复制和落地使用入口，不单独定义新的工程规则。

> 本项目独立维护，不隶属于 OpenAI、Cursor、Anthropic 或任何参考框架。具体灵感参考与许可证边界见根目录 `ATTRIBUTION.md`。

## 使用边界

- 英文根目录保持发布基线和结构基线。
- `zh-CN/` 只翻译当前仓库的 Codex、Claude Code、Skills 和文档入口。
- 归档目录 `codex-research-design-studio` 只作为中文术语和表达种子。
- Cursor 平台专用中文兼容包继续保留在 `cursor/zh-CN/`。
- 不把灵感参考表述为直接派生、实质移植或上游背书。

## 三层结构

```text
Layer 1: 全局指令
  zh-CN/codex/global/AGENTS.md
  zh-CN/claude/global/CLAUDE.md

Layer 2: 项目工程纪律
  zh-CN/codex/project/AGENTS.md
  zh-CN/claude/project/CLAUDE.md

Layer 3: 交付物驱动 Skills
  zh-CN/skills/rd-*/SKILL.md
  zh-CN/claude/project/.claude/skills/rd-*/SKILL.md
```

## 快速开始

### Codex

安装全局指令：

```bash
cp zh-CN/codex/global/AGENTS.md ~/.codex/AGENTS.md
```

安装项目规则：

```bash
cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

安装 Skills：

```bash
cp -r zh-CN/skills/rd-* ~/.agents/skills/
```

如目标文件已存在，请手动合并，不要直接覆盖。

### Claude Code

安装用户级 Claude Code memory：

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

安装项目级 Claude Code 规则和 Skills：

```bash
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

### Cursor

Cursor 中文适配包位于：

```text
cursor/zh-CN/
```

复制方式：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
```

## 文件清单

```text
zh-CN/
  README.md
  PROMPTS.md
  codex/
    global/AGENTS.md
    project/AGENTS.md
    examples/
      config.example.toml
      config.full-access.example.toml
  claude/
    README.md
    global/CLAUDE.md
    project/CLAUDE.md
    project/.claude/settings.json
    project/.claude/skills/rd-*/SKILL.md
  skills/
    rd-*/SKILL.md
  docs/
    compatibility.md
    installation.md
    mcp-routing.md
    design-principles.md
```

## 安全默认值

- Codex 示例配置默认使用 `workspace-write`，不默认启用 `danger-full-access`。
- 外部 MCP server 默认禁用，直到凭据、数据流和使用场景被明确审查。
- 不使用 `@latest` 作为 npm MCP 包版本。
- Claude Code 项目设置默认禁止读取 `.env` 和 `secrets/`，并对 commit、push、tag、publish、delete 操作要求确认。
- Context7 保持当前已验证 pin：`@upstash/context7-mcp@2.3.0`，不升级到 `3.0.0`，直到工具名、认证方式和平台兼容性重新验证完成。

## 版本维护

英文根目录是唯一发布基线。更新英文 rules、skills、MCP 版本或平台适配后，再同步本目录。

同步时至少检查：

- `zh-CN/skills/rd-*` 与根目录 `skills/rd-*` 数量一致；
- `zh-CN/claude/project/.claude/skills/rd-*` 与 `zh-CN/skills/rd-*` 数量一致；
- JSON/TOML 可解析；
- 不引入真实 secrets、私有 relay URL 或旧仓库名；
- 不把灵感参考写成直接派生或上游背书。
