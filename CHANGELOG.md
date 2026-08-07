# Changelog

All notable changes to this project should be documented here.

This project uses GitHub releases for versioning. Directory names should not contain edition or version suffixes such as `v4` or `-en`.

## Unreleased

## 1.0.0 - 2026-08-07

- Created the public `codex-three-layer-delivery` repository layout.
- Split safe Codex configuration from full-access advanced configuration.
- Added GitHub-ready metadata: license, contribution guide, security policy, attribution notes, compatibility docs, and validation script.
- Included Codex rules, Cursor adapter, Claude Code adapter, Simplified Chinese translation pack, and nine `rd-*` skills.
- Added an English Cursor adapter under `cursor/project/`, aligned Cursor `zh-CN` with the same opt-in MCP posture, and documented the official Cursor Rules, Skills, and MCP baseline.
- Refreshed public Codex configuration examples for `codex-cli 0.147.0` and restored the personal normal/high reasoning-profile split.
- Reduced project `AGENTS.md` to a stable control plane and strengthened the nine RD Skills, mirrored evaluations, authority boundaries, and sensitive-evidence handling using the audited `mattpocock/skills v1.2.3` mechanisms.
- Upgraded global `AGENTS.md` to v7.2 with independent always-on truthfulness, response-mode, context-health, pre-output-review, output-contract, Skill-routing, and minimum-RD controls; added a verified PowerShell installer with backup, rollback, staging, and exact-tree validation for all nine RD Skills.
