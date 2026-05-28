# Installation

This repository provides templates. Merge them into your local Codex and project setup rather than overwriting existing files blindly.

## Codex Rules

Install global rules:

```bash
cp codex/global/AGENTS.md ~/.codex/AGENTS.md
```

Install project rules:

```bash
cp codex/project/AGENTS.md /path/to/your-project/AGENTS.md
```

If your destination already has `AGENTS.md`, merge manually and keep project-specific constraints.

## Skills

Global install:

```bash
cp -r skills/rd-* ~/.agents/skills/
```

Project-level install:

```bash
mkdir -p /path/to/your-project/.agents/skills
cp -r skills/rd-* /path/to/your-project/.agents/skills/
```

## Codex Configuration

Start from the safe example:

```bash
cp codex/examples/config.example.toml ~/.codex/config.toml
```

If a config already exists, merge only the relevant sections.

The full-access profile is opt-in:

```text
codex/examples/config.full-access.example.toml
```

Do not use full access for untrusted repositories.

## Environment Variables

Copy the environment example:

```bash
cp .env.example .env
```

Fill only the API keys for MCP servers you enable. Never commit `.env`.

On Windows, user-level environment variables can also be set with `setx`, but restart your shell, Codex CLI, or Codex app after changing them.

## Cursor Adapter

Copy the `cursor/zh-CN/.cursor` directory into a Cursor workspace if you want to use the Cursor adapter.

The Cursor adapter is optional and should be kept aligned with the Codex rules when rules change.
