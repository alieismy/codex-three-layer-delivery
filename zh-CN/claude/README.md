# Claude Code 简体中文适配包

本仓库主要面向 Codex；Claude Code 支持作为可选适配层提供。本目录将 Codex Three-Layer Delivery 的三层交付模型映射到 Claude Code 的原生文件约定。

参考的 Claude Code 官方载体：

- memory（记忆）：`CLAUDE.md`
- settings：`.claude/settings.json`
- skills：`.claude/skills/*/SKILL.md`

官方文档：

已于 2026-07-10 核查：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/skills

## 当前结构

```text
zh-CN/claude/
  global/CLAUDE.md
  project/CLAUDE.md
  project/.claude/settings.json
  project/.claude/skills/rd-*/
    SKILL.md
    evals/*.json
    references/*.md  # 按需提供
```

## 安装

安装用户级 Claude Code memory（记忆）：

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

安装项目级 Claude Code 规则和 Skills：

```bash
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

如果目标文件已存在，请手动合并。不要盲目覆盖已有 `CLAUDE.md`、`.claude/settings.json` 或 Skills。

## 公开发布姿态

首次公开发布时，Claude Code 支持应作为可选能力处理：

- Codex 规则和 Skills 仍是稳定基线。
- Claude Code 文件用于兼容和迁移参考。
- 变更 `CLAUDE.md`、`.claude/settings.json` 或 `.claude/skills/` 行为前，应重新核查 Claude Code 文件约定。
