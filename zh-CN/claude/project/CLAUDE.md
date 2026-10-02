# CLAUDE.md - Claude Code 项目适配（v7）

@AGENTS.md

## Claude Code

共享项目规则通过上方的 `AGENTS.md` 导入。项目通用规则只在 `AGENTS.md` 中维护，使 Codex、Claude Code 和其他代理读取同一来源；本文件只保留 Claude Code 专有指引。

- 项目 Skills 位于 `.claude/skills/rd-*/SKILL.md`。Claude 可根据描述自动选择；需要时用 `/rd-*` 显式调用。`rd-delivery` 遵循 `AGENTS.md` 中按请求内容判定的规则。
- `.claude/settings.json` 禁止读取常见密钥文件，并在 commit、push、tag、publish、delete 以及会丢弃未提交工作的 Git 命令前要求确认。这些规则是防护措施，不是完整安全边界；关键禁止项应优先使用 settings、permissions 或 hooks，而不是只依赖文字提醒。
- 不要把 Codex 专用 `config.toml`、Codex hooks 或 Cursor `.mdc` 语法粘贴到 Claude Code 文件中，应转换为 Claude Code 原生载体。
- 已批准且稳定的 Claude Code 专有约定写在本文件；项目通用约定写入 `AGENTS.md`。
