# Changelog

All notable changes to this project should be documented here.

This project uses GitHub releases for versioning. Directory names should not contain edition or version suffixes such as `v4` or `-en`.

## Unreleased

## 1.7.2 - 2026-09-16

- Clarified the English and Simplified Chinese README Skill taxonomy as eight independently usable specialist Skills plus the explicit-only `rd-delivery` orchestrator, eliminating the apparent mismatch between the stated count and the nine-row table.
- Corrected the English and Simplified Chinese Cursor adapter README evidence dates by separating the 2026-09-16 Rules and Skills documentation check from the retained 2026-09-11 MCP documentation check and installed-version observation.

## 1.7.1 - 2026-09-16

- Refreshed registry latest snapshots in the compatibility documents: `@anthropic-ai/claude-code` `2.1.273` and `@upstash/context7-mcp` `4.1.1` observed on 2026-09-16; `@openai/codex` remains `0.154.0`. Tested versions and the Context7 `4.0.2` pins are unchanged.
- Documented Cursor's multi-source Skill discovery risk across `.agents`, `.cursor`, `.claude`, and `.codex` roots, including the common shared-Skill plus Cursor-adapter combination, the absence of documented same-name precedence or deduplication, and the always-on behavior of `CLAUDE.md`; added the guidance to the Cursor adapter README, installation guide, and compatibility document with their Simplified Chinese mirrors.
- Clarified in the root maintainer `AGENTS.md` that repository authority intent does not prove editor runtime precedence, and recorded the 2026-09-16 Cursor instruction-loading observation as an unresolved, not independently reproduced compatibility risk rather than a universal loading contract.

## 1.7.0 - 2026-09-13

- Clarified that existing authorization remains effective until scope, risk, or external effects materially change, while retaining approval gates for new external actions.
- Distinguished a primary controlling deliverable from explicitly requested companion outputs and reduced the global RD fallback to routing pointers plus a minimal evidence and authority contract.
- Tightened the personal research, Skill-installation, and handoff workflows so durable files, background delegation, global installation, and task-management actions follow explicit scope and canonical output rules.
- Added least-privilege guidance for external communication, account actions, and personal data access, with read-only, local, and redacted evidence preferred when sufficient.
- Added authorization, recoverability, running-task, recovery-path, and evidence-chain checks for deletion and cleanup across Codex, Claude Code, and Cursor global guidance.

## 1.6.0 - 2026-09-07

- Tuned the Codex runtime and public instruction templates for GPT-6 Astra: unified the personal main and subagent model selection, set main, plan, and subagent reasoning effort to `medium`, reduced developer instructions to three Astra-specific controls, and made low-risk discovery guidance conditional instead of ritualized.
- Aligned the standard Codex examples with the reviewed runtime contract for live search, Memories, full shell inheritance, and default sensitive-name exclusions; added a pinned Codex `0.153.4` configuration schema, offline four-file semantic validation, and a networked release gate for live-schema comparison, CLI-version matching, and isolated strict loads.
- Reduced Cursor's always-on Project Rules from ten to one, made the other nine trigger-oriented, removed arbitrary effort/line/time thresholds and duplicated Skill completion tables, and aligned Claude/Cursor anti-anchoring, context-repair, and approval-gated durable-guidance rules.
- Added Windows PowerShell confirmation patterns and common `.env` read denials to both Claude Code project settings, reduced the Cursor MCP example to Context7 only, refreshed compatibility evidence, and expanded validator regression coverage from sixteen to twenty cases.
- Corrected GSD attribution to identify `open-gsd/gsd-core` as the current canonical repository while retaining `gsd-build/get-shit-done` as an archived historical reference; recorded licenses for the vendored schema and new validation dependencies.

## 1.5.0 - 2026-08-31

- Added a bilingual value-first execution contract across the repository maintainer rules, Codex global/project templates, Claude adapters, and Cursor rules; upgraded Codex global templates to v7.8 and Claude global templates to v5; made `rd-delivery` stage-aware with layered verification and re-entry conditions; and extended the negative runner from fourteen to sixteen cases.
- Added an English canonical and Simplified Chinese copy-ready personalized custom-instructions guide for system-design and architecture work, with explicit boundaries between personal preferences, Codex `AGENTS.md`, project rules, and detailed Skills.
- Documented read-only Codex instruction-source verification and an advanced, bounded Claude Code `@AGENTS.md` import option in the English and Simplified Chinese installation and adapter guides.
- Added a bounded external-stakeholder questionnaire mode to `rd-requirement`, pointer-only orchestration in `rd-delivery`, bilingual and platform-mirrored trigger/output evals, and parser-backed Skill YAML/reference validation with two new negative regressions.

## 1.4.0 - 2026-08-24

- Corrected Claude Code permission and attribution semantics, platform-specific prompt prefixes, Cursor `.mdc` guidance and per-server MCP credential isolation, overwrite-safe Unix Skill installation, bilingual adapter instructions, and current registry snapshots; added executable regression coverage for these platform contracts.
- Upgraded the public Codex global `AGENTS.md` templates to v7.7 with evidence-driven execution-efficiency and context-hygiene controls for long-running waits, locally aggregated output, complete final gates, deterministic-failure analysis, and bounded flaky retries; added bilingual validator markers and a dedicated negative regression without changing Codex configuration or other platform adapters.

## 1.3.0 - 2026-08-23

- Upgraded the public Codex global `AGENTS.md` templates to v7.6 with existing-behavior, compatibility, and instruction-surface protection plus validation-failure attribution; extended bilingual validator and negative coverage, corrected the documented negative runner to twelve cases, and preserved the project, RD Skill, Claude, and Cursor scope boundaries.

## 1.2.0 - 2026-08-21

- Upgraded the public Codex global `AGENTS.md` templates to v7.5 with bounded implementation discipline for speculative abstractions, meaningful duplication, naming, trust-boundary validation, boolean modes, implementation comments, iterative clarification, and uncommitted-work protection; added bilingual validator enforcement and negative coverage without expanding project or RD Skill coding scope.

## 1.1.0 - 2026-08-18

- Added a repository-maintainer root `AGENTS.md`, revision-aware context reuse and dynamic-state boundaries across project adapters, a greenfield open-source research/solution-gate prompt, and an optional high-impact bidirectional-argument clarification preamble with negative validator coverage.
- Corrected Simplified Chinese lifecycle-state, authority, source-of-truth, standards-routing, and platform-installation semantics across canonical Skills, evals, prompts, documentation, and maintained adapter mirrors.
- Updated the public global AGENTS templates to v7.4 and synchronized Codex, Claude, Cursor, English, and Simplified Chinese evidence-state and no-change controls.
- Upgraded the Context7 example baseline to `4.0.2`, documented the bounded stdio probe, and added cross-file version enforcement.
- Added RD research/review evals for evidence-layer boundaries and supported no-change outcomes, plus a real negative regression suite for the repository validator.
- Defined `.tmp/local/` as ignored task-local storage and added a bilingual maintainer release checklist without expanding RD Skill scope.

## 1.0.0 - 2026-08-07

- Created the public `codex-three-layer-delivery` repository layout.
- Split safe Codex configuration from full-access advanced configuration.
- Added GitHub-ready metadata: license, contribution guide, security policy, attribution notes, compatibility docs, and validation script.
- Included Codex rules, Cursor adapter, Claude Code adapter, Simplified Chinese translation pack, and nine `rd-*` skills.
- Added an English Cursor adapter under `cursor/project/`, aligned Cursor `zh-CN` with the same opt-in MCP posture, and documented the official Cursor Rules, Skills, and MCP baseline.
- Refreshed public Codex configuration examples for `codex-cli 0.147.0` and restored the personal normal/high reasoning-profile split.
- Reduced project `AGENTS.md` to a stable control plane and strengthened the nine RD Skills, mirrored evaluations, authority boundaries, and sensitive-evidence handling using the audited `mattpocock/skills v1.2.3` mechanisms.
- Upgraded global `AGENTS.md` to v7.2 with independent always-on truthfulness, response-mode, context-health, pre-output-review, output-contract, Skill-routing, and minimum-RD controls; added a verified PowerShell installer with backup, rollback, staging, and exact-tree validation for all nine RD Skills.
