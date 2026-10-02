# Claude Code 简体中文适配包

本仓库主要面向 Codex；Claude Code 支持作为可选适配层提供。本目录将 Codex Three-Layer Delivery 的三层交付模型映射到 Claude Code 的原生文件约定。

参考的 Claude Code 官方载体：

- memory（记忆）：`CLAUDE.md`
- settings：`.claude/settings.json`
- skills：`.claude/skills/*/SKILL.md`

官方文档：

已于 2026-09-04 重新核查；memory 页面已于 2026-10-01 针对 `AGENTS.md` 支持再次核查：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/skills

## 当前结构

```text
zh-CN/claude/
  global/CLAUDE.md
  project/CLAUDE.md          # 薄适配：@AGENTS.md + Claude Code 专有指引
  project/.claude/settings.json
  project/.claude/skills/rd-*/
    SKILL.md
    evals/*.json
    references/*.md  # 按需提供
```

项目 settings 默认禁止读取工作目录及其任意子目录中的常见密钥文件，并在匹配 Bash 或 Windows PowerShell 的 commit、push、tag、publish、delete 以及会丢弃未提交工作的 Git 命令前缀（`reset --hard`、`clean`、`checkout --`、`restore`）时要求确认；Read 拒绝规则自 v2.1.208 起覆盖同一路径的内置 Edit，自 v2.1.228 起覆盖 Write，但不覆盖 NotebookEdit；如需禁止所有内置工具修改特定路径，应使用 Edit 拒绝规则；这些规则无法阻止自行打开文件的任意脚本，且 Windows 不支持 Claude Code 沙箱；这些模式是防护措施，不是对所有包装命令和复合命令的完整安全边界。

## 安装

安装用户级 Claude Code memory（记忆）：

```bash
(
set -e
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
)
```

安装共享项目核心和 Claude Code 项目适配文件。目标项目已有 `AGENTS.md`（例如已按 Codex 方式安装）时保留并手动合并，不要覆盖：

```bash
(
set -e
if [ -e /path/to/your-project/CLAUDE.md ] || [ -L /path/to/your-project/CLAUDE.md ] || [ -e /path/to/your-project/.claude ] || [ -L /path/to/your-project/.claude ]; then
  printf '%s\n' 'Stop: merge existing Claude project files manually before installing.' >&2
  exit 1
fi
if [ -s /path/to/your-project/AGENTS.override.md ]; then
  printf '%s\n' 'Stop: merge the effective override and select the Claude import target manually before installing.' >&2
  exit 1
fi
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
)
```

如果目标文件已存在，请手动合并。不要盲目覆盖已有 `CLAUDE.md`、`.claude/settings.json` 或 Skills。

存在非空 `AGENTS.override.md` 时，示例会在安装适配文件前停止。应先有意识地合并这一 Codex 生效来源，再选择对应的 Claude 导入（例如 `@AGENTS.override.md`）后继续；Claude 不会自动发现 override 文件。已有但为空的 `AGENTS.md` 也必须先手动修复。

Bash 项目安装在子 shell 中运行，guard 失败不会退出父交互式 shell。Windows 用户可使用[原生 PowerShell 示例](../docs/installation.md#windows-powershell-项目安装)。

## 共享项目核心

`project/CLAUDE.md` 是薄适配文件：其中的 `@AGENTS.md` 行导入来自 `zh-CN/codex/project/AGENTS.md` 的共享项目核心，其余内容只保留 Claude Code 专有指引。项目通用行为应修改 `zh-CN/codex/project/AGENTS.md`，不要改适配文件。

Claude Code v2.1.277 及以上版本可直接读取 `AGENTS.md`，但仅限不存在 `CLAUDE.md` 的情况。本适配包含 `CLAUDE.md`，因此通过显式导入保持 `AGENTS.md` 被加载；该方式同样适用于更早版本，且不会重复加载（[memory 文档](https://code.claude.com/docs/en/memory#agents-md)，2026-10-01 核查）。在 Windows 上应使用导入而不是软链接。可在新会话中运行 `/memory` 或 `/context` 确认两个文件均已加载。

导入只共享文本指令，不能替代 Claude Code 的 settings、permissions、hooks、Skill 发现或其他平台控制；导入内容仍会占用上下文。Cursor 也会同时读取 `AGENTS.md` 和 `CLAUDE.md`，同时使用两个适配包前应先审查这一组合。

## 公开发布姿态

首次公开发布时，Claude Code 支持应作为可选能力处理：

- Codex 规则和 Skills 仍是稳定基线。
- Claude Code 文件用于兼容和迁移参考。
- 变更 `CLAUDE.md`、`.claude/settings.json` 或 `.claude/skills/` 行为前，应重新核查 Claude Code 文件约定。
