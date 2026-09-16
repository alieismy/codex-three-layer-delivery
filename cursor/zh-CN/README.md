# Cursor 三层交付体系适配包（zh-CN）

本目录是 Codex Three-Layer Delivery 的 Cursor 兼容适配包，面向中文使用场景。

## 当前状态

- `.cursor/rules/*.mdc`：按 Cursor 规则文件拆分的文档交付纪律。
- `.cursor/skills/rd-*/SKILL.md`：Cursor 版 `rd-*` 技能。
- `.cursor/mcp.example.json`：显式选择启用（opt-in）的 MCP 示例配置。
- `PROMPTS.md`：中文提示词模板。

## Cursor 官方文档基线

已于 2026-09-11 重新核查 Cursor 官方文档和本机 Windows 桌面版本（`3.20.10`，system setup）：

- [Rules](https://cursor.com/docs/rules.md)：项目规则必须是 `.cursor/rules` 下的 `.mdc` 文件；规则系统会忽略普通 `.md` 文件。需要普通 Markdown 指令时，应使用 `AGENTS.md`。
- [Skills](https://cursor.com/docs/skills.md)：Agent Skills 是可版本化的能力包，可包含脚本、模板和参考资料。
- [MCP](https://cursor.com/docs/mcp.md)：项目级 MCP 配置文件是 `.cursor/mcp.json`。

## 使用方式

只有 `00-global-principles.mdc` 常驻加载；其余 9 条项目规则使用触发条件优先的描述，并按需加载。

将 `.cursor/` 目录复制到目标 Cursor 项目根目录：

```bash
if [ ! -e /path/to/your-project/.cursor ]; then
  cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
fi
if [ ! -e /path/to/your-project/PROMPTS.cursor.zh-CN.md ]; then
  cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
fi
```

如果目标项目已经有 `.cursor/` 或 `PROMPTS.cursor.zh-CN.md`，请先备份并手动合并，不要直接覆盖。

## 可选 MCP 配置

本目录不直接发布活动 `.cursor/mcp.json`，而是发布只包含 Context7 的最小示例文件：

```text
cursor/zh-CN/.cursor/mcp.example.json
```

需要启用 MCP 时，先审查数据流、凭据和使用场景，再复制为目标项目的 `.cursor/mcp.json`：

```bash
cp cursor/zh-CN/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

在宿主环境中设置 `CONTEXT7_API_KEY`。示例通过该凭据型 server 自己的 `env` 对象，只向它映射一个 API key；不得改用共享 `envFile`，也不得把 key 放入命令参数。修改宿主环境变量后应重启 Cursor，再在 UI 中重新检查 MCP 状态。

其它 server 只有在存在已验证用途时才逐项添加。`docs/mcp-routing.md` 是路由指南，不是应整体复制的配置目录。

不要假定 `disabled`、`alwaysAllow` 等字段属于 Cursor 官方稳定 MCP 配置面。本仓库的公开模板不依赖这些字段。

## 与其它适配包共存安装

Cursor 会从 `.agents/skills/`、`.cursor/skills/`、`~/.agents/skills/` 和 `~/.cursor/skills/` 发现 Skills，也会加载兼容的 `.claude/skills/`、`.codex/skills/`、`~/.claude/skills/` 和 `~/.codex/skills/`（[Cursor Skills](https://cursor.com/docs/skills.md)）。官方文档没有定义在多个根中发现同名 Skill 时的优先级或去重行为。安装本适配包前，应盘点全部发现根。只选择一个项目适配包，不能消除用户级根中已有的同名定义。

常规的共享/Codex 安装会把 Skills 放在 `~/.agents/skills/` 或项目 `.agents/skills/`，再与本适配包的 `.cursor/skills/` 组合时，即使未安装 Claude Code，也已经会产生多个同名 `rd-*` 可发现定义。不要通过直接省略 Cursor Skill 目录来解决：Cursor 的 `rd-delivery` 镜像带有平台专用的 `disable-model-invocation: true` 护栏，而 Codex 通过 `agents/openai.yaml` 实现同一显式调用策略。本仓库目前还没有一套经过运行验证、既消除同名选择歧义又保留所有客户端平台专用调用契约的通用安装方案。若只使用 Cursor，应确保 Cursor 副本是该环境中每个 `rd-*` Skill 唯一可发现的定义。如 Cursor 必须与 Codex 或 Claude Code 共用环境，应保留平台专用副本，在新会话中验证 Cursor 实际选择的定义以及 `rd-delivery` 是否仍只能显式调用，并记录接受的安装安排。移除或迁移既有 Skill 副本前，应取得与其作用域相称的授权。

安装 Claude Code 适配包还会增加 `.claude/skills/` 和项目级 `CLAUDE.md`。Cursor 读取 `CLAUDE.md` 的方式与 `AGENTS.md` 相同，且会将其应用于每个会话，不受任何 `alwaysApply` 设置影响（[Cursor rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor)，2026-09-16 核查）。组合适配包前，应同时审查同名 Skill 来源和常驻指令文件；在目标 Cursor 运行时验证完成前，不应声称它们已经去重。

Cursor 支持嵌套 `AGENTS.md`，并说明它们在处理其所在目录或后代目录中的文件时应用，且更具体的指令优先（[Cursor rules](https://cursor.com/docs/rules.md)）。因此嵌套保留的适配包副本可能在维护对应子树时与仓库维护者指令冲突；不要假定根指令文件一定能覆盖它们。

## 公开发布说明

此适配包保留中文内容。英文 Cursor 适配包（adapter）位于 `cursor/project/`；英文根目录仍是权威基线（canonical baseline）。
