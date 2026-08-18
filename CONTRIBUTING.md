# Contributing

Contributions are welcome when they improve the framework without weakening its core constraints: evidence discipline, minimal-change execution, safety defaults, and final verification.

## Contribution Types

- maintainer-rule improvements for the root `AGENTS.md`, or distributable-rule improvements for `codex/global/AGENTS.md` and `codex/project/AGENTS.md`;
- skill improvements under `skills/rd-*`;
- Cursor adapter updates under `cursor/`;
- documentation updates under `docs/`;
- compatibility updates for Codex CLI or MCP packages.

## Required Checks

Before opening a pull request:

```powershell
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
```

If you change MCP package versions, update `docs/compatibility.md` with:

- package name;
- tested version;
- verification date;
- highest evidence state actually reached and unverified client/runtime layers;
- whether the server is enabled by default.

Use `.tmp/local/` for task-local clones, downloads, logs, and probes. Do not place durable artifacts or the only copy of evidence there. Files already tracked directly under `.tmp/` are not implicitly disposable.

## Rules and Skills Guidelines

- Keep rules concrete and verifiable.
- Do not add broad personality text that does not affect execution.
- Do not hardcode personal paths, tokens, accounts, or private relay URLs.
- Do not use `@latest` for npm-based MCP examples.
- Keep skill descriptions trigger-oriented: start with `Use when...` when possible.
- If a rule compensates for a temporary model limitation, mark it as a rule that should be reviewed periodically.

## Pull Request Summary

Please include:

- what changed;
- why it changed;
- files touched;
- validation performed;
- known risks or unverified areas.

Repository publication follows the [maintainer release checklist](docs/release-checklist.md). Pull-request approval does not by itself authorize merge, tag, or public Release creation.
