# 安装说明

本仓库提供模板。请把模板合并进你的本地 Codex、Claude Code 或项目配置，不要盲目覆盖已有文件。

## Codex 规则

安装全局规则：

```bash
mkdir -p ~/.codex
if [ ! -e ~/.codex/AGENTS.md ]; then
  cp zh-CN/codex/global/AGENTS.md ~/.codex/AGENTS.md
fi
```

安装项目规则：

```bash
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

如果任一目标已有 `AGENTS.md`，请先创建独立备份，再只合并需要的章节，并保留现有个人或项目特定约束；不得直接替换个人全局文件。模板包含角色、语言、推理深度、授权和交付纪律等观点化默认值，应按实际用户、团队与仓库调整；`zh-CN/` 全局模板有意默认使用简体中文。

Codex 加载全局和适用的项目 `AGENTS.md` 规则链，这一过程不依赖是否选中 Skill。因此，全局 v7.4 模板把真实性纪律、响应模式、上下文健康、输出前审核、输出规则、证据状态边界、“无需修改”合法性和精简的 RD 交付基线作为常驻能力：未触发 RD Skill 时仍然生效；触发匹配 Skill 后，只叠加完整专业工作流，不会替代或补回这些控制规则的唯一副本。

## Codex Skills

全局安装：

```bash
cp -r zh-CN/skills/rd-* ~/.agents/skills/
```

在 PowerShell 中，推荐使用带完整校验的用户级安装脚本：

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -CheckOnly
```

该脚本只管理声明的 9 个 `rd-*` 目录：先在 `$HOME/.agents/backups` 下建立并校验 SHA-256 备份，再暂存并校验待安装文件；替换失败时恢复原安装，成功后逐文件比对安装树与所选源目录。`-CheckOnly` 只执行最终比对，不写入文件。

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

英文根目录仍是权威基线；`zh-CN/` 是简体中文翻译包。目标文件已存在时，应手动合并，避免覆盖本地项目规则。
