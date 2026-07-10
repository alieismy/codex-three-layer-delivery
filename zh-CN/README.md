# Codex Three-Layer Delivery 简体中文包

本目录是 `Codex Three-Layer Delivery` 的简体中文翻译包（translation pack）。本项目面向系统设计师、系统架构师、技术方案作者、产品经理和标准/文档评审人员，聚焦需求分析、可研、方案、概要设计、详细设计、标准规范和文档评审。英文根目录是权威基线（canonical baseline）；本目录只提供中文阅读、复制和安装使用入口，不单独定义新的工程规则。

> 本项目独立维护，不隶属于 OpenAI、Cursor、Anthropic 或任何参考框架。具体灵感参考与许可证边界见根目录 `ATTRIBUTION.md`。

## 使用边界

- 英文根目录保持发布基线和结构基线。
- `zh-CN/` 只翻译当前仓库的 Codex、Claude Code、Skills 和文档入口。
- 归档目录 `codex-research-design-studio` 只作为中文术语和表达种子。
- Cursor 英文适配包位于 `cursor/project/`；Cursor 平台专用中文兼容包继续保留在 `cursor/zh-CN/`。
- 不把灵感参考表述为直接派生、实质移植或上游背书。

## 三层结构

```text
Layer 1: 全局指令
  zh-CN/codex/global/AGENTS.md
  zh-CN/claude/global/CLAUDE.md

Layer 2: 项目文档交付纪律
  zh-CN/codex/project/AGENTS.md
  zh-CN/claude/project/CLAUDE.md

Layer 3: 文档交付 Skills
  zh-CN/skills/rd-*/SKILL.md
  zh-CN/claude/project/.claude/skills/rd-*/SKILL.md
```

核心 Skill：

| Skill | 主要交付物 | 典型工作 |
|------|------------|----------|
| `$rd-requirement` | PRD / SRS / 结构化需求 | 需求分析、场景建模、优先级和验收标准 |
| `$rd-feasibility` | 可研报告 / 可行性分析 | 技术、经济、进度、合规、运行和风险可行性评估 |
| `$rd-research` | 证据包 / 文献资料 / 来源笔记 | 为可研、方案、标准规范或事实依赖型评审收集和核验证据 |
| `$rd-solution` | 技术方案 / 概要设计 / 建设方案 | 候选方案比较、推荐方案、架构和建设设计 |
| `$rd-design` | 详细设计文档 | 接口、数据模型、流程、状态机、错误和安全设计 |
| `$rd-specification` | 标准规范草案 / 条款级修订 | 国家、行业、企业或内部标准规范制定与修订 |
| `$rd-review` | 文档评审报告 | 需求、可研、方案、设计、标准规范评审 |

这些 Skill 可独立使用，不强制组成流水线。`$rd-research` 用于需要外部证据的场景，是可研、技术方案、标准规范和事实依赖型评审的推荐伴随能力，不是所有任务的强制前置步骤。

每个 Skill 都在 `evals/` 下提供输出质量和触发边界用例。`rd-review` 在 `SKILL.md` 中保留公共框架，只按所选文档类型加载 `references/` 中的检查表。共享 Skill 正文使用中性 `rd-*` 标识；Codex 示例使用 `$rd-*`，Cursor 和 Claude Code 显式调用使用 `/rd-*`。

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

安装用户级 Claude Code memory（记忆）：

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

安装项目级 Claude Code 规则和 Skills：

```bash
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

### Cursor

Cursor 英文适配包位于：

```text
cursor/project/
```

Cursor 中文适配包位于：

```text
cursor/zh-CN/
```

复制方式：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
```

Cursor MCP 配置以 `mcp.example.json` 形式发布。需要启用时，先审查凭据和数据流，再复制为目标项目的 `.cursor/mcp.json`。

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
- 外部 MCP 服务器默认禁用，直到凭据、数据流和使用场景被明确审查。
- Cursor 适配包只发布 `.cursor/mcp.example.json`，不直接发布活动 `.cursor/mcp.json`。
- 不使用 `@latest` 作为 npm MCP 包版本。
- Claude Code 项目设置默认禁止读取 `.env` 和 `secrets/`，并对 commit、push、tag、publish、delete 操作要求确认。
- Context7 保持当前已验证固定版本：`@upstash/context7-mcp@2.3.0`，不升级到 `3.0.0`，直到工具名、认证方式和平台兼容性重新验证完成。

## 版本维护

英文根目录是唯一发布基线。更新英文 rules、skills、MCP 版本或平台适配后，再同步本目录。

同步时至少检查：

- `zh-CN/skills/rd-*` 与根目录 `skills/rd-*` 数量一致；
- `zh-CN/claude/project/.claude/skills/rd-*` 与 `zh-CN/skills/rd-*` 数量一致；
- JSON/TOML 可解析；
- 不引入真实 secrets、私有 relay URL 或旧仓库名；
- 不重新引入编码开发、代码评审、测试执行或部署执行类 Skill；
- 不把灵感参考写成直接派生或上游背书。
