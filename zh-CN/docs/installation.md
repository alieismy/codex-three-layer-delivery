# 安装说明

本仓库提供模板。请把模板合并进你的本地 Codex、Claude Code 或项目配置，不要盲目覆盖已有文件。

## Codex 规则

安装全局规则：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi
```

安装项目规则：

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

如同一层级存在非空 `AGENTS.override.md`，它是当前生效的指令来源；应先创建独立备份并有意识地合并，不要创建不会生效的 `AGENTS.md`。如已有 `AGENTS.md`，也应先备份，再只合并需要的章节，并保留现有个人或项目特定约束；不得直接替换个人全局文件。模板包含角色、语言、推理深度、授权和交付纪律等观点化默认值，应按实际用户、团队与仓库调整；`zh-CN/` 全局模板有意默认使用简体中文。

Codex 加载全局和适用的项目 `AGENTS.md` 规则链，这一过程不依赖是否选中 Skill。因此，全局 v7.8 模板把真实性纪律、响应模式、价值优先执行、上下文健康、执行效率与上下文卫生、输出前审核、输出规则、证据状态边界、“无需修改”合法性、有边界的实现纪律、既有行为与指令面保护、验证失败归因和精简的 RD 交付基线作为常驻能力：未触发 RD Skill 时仍然生效；触发匹配 Skill 后，只叠加完整专业工作流；上述控制规则仍由全局模板常驻提供，不以 Skill 作为唯一来源。

Codex 在每次运行开始时发现一次指令链。同一层级存在非空 `AGENTS.override.md` 时，它优先于 `AGENTS.md`；全局规则先加载，项目规则再从仓库根目录向当前工作目录依次加载，因此更靠近当前目录的规则优先级更高。合并内容达到 `project_doc_max_bytes` 后停止加载；修改指令文件后，需要新建运行或会话才会生效。详见 OpenAI 官方文档 [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)。

### 验证指令加载

在仓库根目录启动一次新的非交互运行，让它报告已加载的全局和项目指令来源：

```text
codex --sandbox read-only --ask-for-approval never exec "Summarize the current instructions and list their source files in precedence order."
```

需要验证更靠近工作目录的 `AGENTS.md` 或 `AGENTS.override.md` 时，再从嵌套目录运行：

```text
codex --cd path/to/nested-directory --sandbox read-only --ask-for-approval never exec "List the instruction sources you loaded in precedence order, then summarize the effective guidance."
```

`--sandbox read-only` 可防止这次诊断运行修改工作区；`--ask-for-approval never` 只禁用审批提示，`never` 本身不提供只读边界。设置 `CODEX_HOME` 后，Codex 从该目录读取全局指令；未设置时默认使用 `~/.codex`。指令文件修改后应再次新建运行，因为指令链只在每次运行或 TUI 会话启动时构建一次。这些检查只能证明该次运行报告了哪些来源以及如何概括其内容，不能保证以后必然遵守，也不构成运行验收或业务验收。详见 OpenAI 官方的 [`codex exec` 说明](https://learn.chatgpt.com/docs/developer-commands#codex-exec)和[只读非交互安全组合](https://learn.chatgpt.com/docs/agent-approvals-security#common-sandbox-and-approval-combinations)。

## Codex Skills

### Skill 来源与作用域

英文 `skills/` 是仓库的 canonical Skill 源；`zh-CN/skills/` 是对应的简体中文翻译包。`~/.agents/skills/`（或 `$HOME/.agents/skills/`）下的用户级副本是已安装的个人副本，不是第二个仓库源。应为每个项目在明确的作用域选择一个明确来源安装。若多个用户级或项目级发现目录中存在同名 Skill，Codex 不会合并这些目录；选择和优先级可能产生歧义，因此应先检查发现到的副本，只有在获得明确授权后才移除或迁移无意中的重复副本。

安装前记录目标语言/来源、目标作用域（用户级或项目级）和 Skill 集合。目标已存在时，应先作合并或替换决策，不得盲目覆盖。下面的 PowerShell 脚本会在替换声明的 9 个 `rd-*` 目录前创建并校验备份；它不授权替换无关 Skill，也不会改变 Codex 的运行时选择策略。

全局安装：

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

在 PowerShell 中，推荐使用带完整校验的用户级安装脚本：

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -CheckOnly
```

该脚本只管理声明的 9 个 `rd-*` 目录：先在 `$HOME/.agents/backups` 下建立并校验 SHA-256 备份，再暂存并校验待安装文件；替换失败时恢复原安装，成功后逐文件比对安装树与所选源目录。`-CheckOnly` 只执行最终比对，不写入文件。

项目级安装：

```bash
skill_target="/path/to/your-project/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

## Codex 配置

从经过评审、具有明确取向的 `workspace-write` 示例开始：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -e "$codex_home/config.toml" ]; then
  cp zh-CN/codex/examples/config.example.toml "$codex_home/config.toml"
fi
```

如果 `$CODEX_HOME/config.toml` 已存在（默认路径为 `~/.codex/config.toml`），先检查实际内容，再只合并需要的片段；不得盲目覆盖正常工作的个人配置。

标准示例有意设置 `web_search = "live"`、启用 `features.memories`、完整继承父 shell 环境，并设置 `ignore_default_excludes = false`，使 Codex 仍过滤名称中含 `KEY`、`SECRET` 或 `TOKEN` 的环境变量。这些选择与维护者已评审的运行基线一致，但不是适用于所有账户、工作区和威胁模型的通用安全或隐私默认值。

高权限配置档需要显式选择：

```text
zh-CN/codex/examples/config.full-access.example.toml
```

不要在不可信仓库中使用 `full access`（完全访问权限）。

## Claude Code 适配包

安装用户级 Claude Code memory（记忆）：

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

复制 Cursor 适配包前，应检查 Cursor 会发现的全部 Skill 根：项目级和用户级 `.agents/skills/`、`.cursor/skills/`、`.claude/skills/` 与 `.codex/skills/`（[Cursor Skills](https://cursor.com/docs/skills.md)）。官方文档没有定义在多个根中发现同名 Skill 时的优先级或去重行为。上文的共享/Codex 安装已经把 `rd-*` 放在 `.agents/skills/` 或 `~/.agents/skills/`；再复制本适配包的 `.cursor/skills/` 时，即使未安装 Claude Code，也会产生多个同名可发现定义。

只选择一个项目适配包，不能消除用户级根中已有的同名副本。不要假定共享 Skill 树可以直接替代 Cursor Skill 树：Cursor 的 `rd-delivery` 镜像带有 `disable-model-invocation: true`，而 Codex 通过 `agents/openai.yaml` 实现同一显式调用策略。因此，本仓库目前还没有一套经过运行验证、既消除同名选择歧义又保留所有客户端平台专用调用契约的通用安装方案。若只使用 Cursor，应确保 Cursor 副本是该环境中每个 `rd-*` Skill 唯一可发现的定义。如 Cursor 必须与 Codex 或 Claude Code 共用环境，应保留平台专用副本，在新的 Cursor 会话中验证实际选择的定义以及 `rd-delivery` 是否仍只能显式调用，并记录接受的安装安排。移除或迁移既有 Skill 副本前，应取得与其作用域相称的授权。

Claude Code 适配包会再增加一个 Skill 根和项目级 `CLAUDE.md`。Cursor 读取 `CLAUDE.md` 的方式与 `AGENTS.md` 相同，并会将其应用于每个会话，不受任何 `alwaysApply` 设置影响（[Cursor rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor)，2026-09-16 核查）。组合适配包前，应同时审查同名 Skill 来源和常驻指令文件；在目标 Cursor 运行时验证完成前，不应声称它们已经去重。详见 `cursor/README.md`。

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

Cursor MCP 需要显式启用。最小示例只包含 Context7。先审查凭据、数据流和使用场景，再把示例文件复制为目标项目的 `.cursor/mcp.json`：

```bash
cp cursor/zh-CN/.cursor/mcp.example.json /path/to/your-project/.cursor/mcp.json
```

配置 `CONTEXT7_API_KEY` 后，在 Cursor MCP 状态中确认 server。其它 server 只有在存在已验证用途时才分别加入，不要把路由说明中的全部候选项一次写入配置。

## 环境变量

复制环境变量示例：

```bash
cp .env.example .env
```

只填写你实际启用的 MCP 服务器所需 API key。不要提交 `.env`。

Windows 用户级环境变量也可用 `setx` 设置，但设置后需要重启 shell、Codex CLI、Codex App、Cursor 或 Claude Code。

英文根目录仍是权威基线；`zh-CN/` 是简体中文翻译包。目标文件已存在时，应手动合并，避免覆盖本地项目规则。
