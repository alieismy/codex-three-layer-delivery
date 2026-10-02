# Compatibility

The npm registry latest versions were rechecked on 2026-10-02; the installed Codex CLI and release schema baseline are `0.160.0`. Claude Code CLI `2.1.287` was observed on 2026-10-02. Other installed versions and runtime observations retain their original dates: Cursor version 2026-09-11, Cursor Rules/Skills/FAQ documentation 2026-09-16, detailed Claude Code documentation 2026-09-04, and the bounded Context7 stdio probe 2026-08-14. Recheck registry versions and decision-relevant tool/API surfaces before each release.

## Codex

| Component | Tested version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@openai/codex` npm package | `0.147.0` | `0.160.0` | Registry latest and installed CLI `0.160.0` were rechecked on 2026-10-02. The tagged `0.160.0` schema was fetched for this release baseline; the release gate compares it with the current live schema and runs the four example checks. The broader tested baseline remains `0.147.0`. Do not hardcode this into the repository name or AGENTS rules. |

The repository vendors the Codex `0.160.0` configuration schema as an offline snapshot with provenance and SHA-256 metadata under `schemas/`. `scripts/validate.ps1` uses the snapshot deterministically; the release-only `scripts/validate-release.ps1` compares it with the current official schema, checks the installed CLI version, validates all four examples against the live copy, and strict-loads each example from an isolated temporary `CODEX_HOME`.

The separate 2026-09-20 [dual-model evaluation](dual-model-compatibility.md) used CLI `0.155.1` and requested `gpt-5.6-sol` and `gpt-6-astra`, both with high reasoning and high verbosity. Supplied-text assertions scored 42/48 and 46/48 respectively; four native attempts were blocked. The report preserves failures and limits, does not verify backend identity or implicit routing, and does not replace the release schema or broader baseline above.

The 2026-10-02 [native routing smoke record](evidence/skill-routing-smoke-2026-10-02.json) retains five synthetic English attempts: four passed the loading expectations and one Codex orchestration attempt timed out after loading the delivery body. Both tools kept `rd-delivery` unloaded for a PRD plus summary without orchestration; Claude completed the unnamed orchestration request. Existing user-level context remained active. This checks bounded selection/loading, not output quality, clean-environment behavior, import completeness, or Cursor compatibility.

The [matched-budget follow-up](evidence/skill-routing-followup-2026-10-02.json) ran T3 and the unhinted T6 with a 300-second limit on both Codex and Claude: all four attempts passed. Explicit orchestration loaded `rd-delivery`; a PRD plus short summary without a negative routing hint did not. These bounded observations preserve the earlier timeout and do not establish statistical stability or document quality.

The [timed Chinese CLI follow-up](evidence/skill-routing-zh-cli-2026-10-02.json) copied Chinese project templates and all nine Chinese Skills into temporary projects. With corrected UTF-8 capture and event-based selection checks, all four 300-second attempts passed; each process and launcher duration is retained. The initial four scoring failures and two file-encoding diagnostic failures remain recorded: the PowerShell collector inherited codepage 936 and misdecoded UTF-8 CLI output, while the old scorer omitted actual Claude Skill calls. A deterministic capture probe verified the fix. These are measurement failures, not established routing regressions. The corrected phase uses the original Chinese prompts without an encoding or routing hint. Existing user-level context and same-name precedence limits remain; this is not desktop acceptance or a reliability estimate. Earlier English elapsed times and the exact Oct 1 invocation timeout remain unmeasured or unknown.

## Claude Code

| Component | Tested/pinned version | Registry latest checked | Notes |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm package | Not pinned by this repository | `2.1.287` | Registry latest and installed CLI `2.1.287` were observed on 2026-10-02. The settings schema, adapter structure, and `claude doctor` were last re-checked with `2.1.260` on 2026-09-04. Dangerous-command permission behavior was not exercised; settings validation is not proof that every wrapper or compound command will be intercepted. |

The [memory documentation](https://code.claude.com/docs/en/memory#agents-md), checked on 2026-10-01, states that Claude Code reads `AGENTS.md` directly from v2.1.277 only when no `CLAUDE.md` is present, and that an `@AGENTS.md` import in `CLAUDE.md` is never read twice. The project adapter therefore uses the import. This is documentation evidence; loading was not verified on the maintainer's installed CLI.

Official Claude Code docs checked: [memory](https://code.claude.com/docs/en/memory), [settings](https://code.claude.com/docs/en/settings), [permissions](https://code.claude.com/docs/en/permissions), and [skills](https://code.claude.com/docs/en/skills).


The [2026-10-01 historical smoke record](evidence/skill-routing-smoke-2026-10-01.json) preserves four completed Codex attempts and four Claude authentication blocks (`Not logged in`). The user confirmed logging in before the Oct 2 Claude passes. No upgrade-fix claim follows. Codex T3 previously completed after about 271 seconds of file capture, while the Oct 2 attempt had a 180-second limit; this is not a controlled routing-regression comparison.

The [2026-10-02 source-maintenance isolation probe](evidence/claude-source-isolation-2026-10-02.json) reproduced nested loading of both Claude global language templates. Excluding their paths suppressed those loads while a control instruction still loaded and synthetic files remained readable. A final-config fixture subsequently read all eight template directories, the positive control and the root maintainer rules. The source repository therefore has a maintainer-only `.claude/settings.json` excluding eight declared instruction templates. Do not copy this root configuration into downstream projects. Direct AGENTS loading does not emit `InstructionsLoaded`, so that hook alone does not establish AGENTS loading or exclusion behavior. Existing user-level context remained active.

A prior installation probe inadvertently executed a user-level copy from a combined installation block and overwrote the user's `~/.claude/CLAUDE.md` with the then-current Chinese public template. The deviation was identified during this follow-up; the original file has not been recovered from a verified backup. Current installation probes isolate HOME and targets, and preserve this limit when interpreting inherited context. No personal identifier or credential is retained here.

The user subsequently confirmed that no original backup exists and authorized the revised Chinese global template as the new baseline. The current personal file was backed up before updating `~/.claude/CLAUDE.md`, and its hash matches the revised template. This adopts a new baseline rather than restoring unknown original content; the probes above precede this update.

## Cursor

The Cursor Rules, Skills, and FAQ documentation was rechecked on 2026-09-16; the installed Windows desktop version observed on 2026-09-11 was `3.20.10` (system setup):

- [Rules](https://cursor.com/docs/rules.md): Project Rules live in `.cursor/rules` as `.mdc` files. Plain `.md` files are ignored by the rules system; use `AGENTS.md` for plain Markdown guidance. Cursor supports nested `AGENTS.md` files, applies them when working with files in their directory or descendants, combines them with parent instructions, and gives more-specific instructions precedence.
- [Skills](https://cursor.com/docs/skills.md): Agent Skills are portable, version-controlled packages that can include scripts, templates, and references. Cursor discovers project and user Skills from `.agents/skills/`, `.cursor/skills/`, `~/.agents/skills/`, and `~/.cursor/skills/`, and also loads `.claude/skills/`, `.codex/skills/`, `~/.claude/skills/`, and `~/.codex/skills/`. The official documentation does not define precedence or deduplication for same-name Skills found in multiple roots. A shared/Codex installation under an Agents root combined with the Cursor adapter's `.cursor/skills/` is already a multi-source installation even without Claude Code. Since 2026-10-01 the shared, Claude Code, and Cursor `rd-delivery` copies carry identical content and no platform-specific invocation flag; same-name selection ambiguity remains.
- [MCP](https://cursor.com/docs/mcp.md): project-specific MCP servers are configured through `.cursor/mcp.json`; global servers use `~/.cursor/mcp.json`.
- [Rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor) (checked 2026-09-16): Cursor reads `CLAUDE.md` the same way it reads `AGENTS.md`, and `CLAUDE.md` files are always applied to every conversation regardless of any `alwaysApply` frontmatter setting. Combining the Claude Code and Cursor adapters therefore adds another always-on instruction file as well as another discoverable Skill source; see `cursor/README.md`.

A 2026-09-16 maintainer session reported that the four distributable `AGENTS.md` templates under `codex/` and `zh-CN/codex/`, plus the English and Chinese Cursor `00-global-principles.mdc` files, were surfaced together as effective instructions. Those six files currently total 64,928 bytes and contain conflicting language directives. This is a single-session runtime observation, not an independently reproduced loading contract; the official nested-`AGENTS.md` documentation describes directory-scoped application instead. No isolation mechanism has been verified. Treat the observation as an unresolved source-repository compatibility risk, not proof that every Cursor session loads all six files or that the root maintainer file overrides them.

| Adapter surface | Repository path | Public-release posture |
|---|---|---|
| English rules | `cursor/project/.cursor/rules/*.mdc` | Cursor-native project rules |
| English skills | `cursor/project/.cursor/skills/rd-*/SKILL.md` | Mirrored from root `skills/rd-*` |
| English MCP example | `cursor/project/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |
| Chinese rules | `cursor/zh-CN/.cursor/rules/*.mdc` | Cursor-specific Simplified Chinese compatibility pack |
| Chinese skills | `cursor/zh-CN/.cursor/skills/rd-*/SKILL.md` | Mirrored from `zh-CN/skills/rd-*` |
| Chinese MCP example | `cursor/zh-CN/.cursor/mcp.example.json` | Example only; copy to `.cursor/mcp.json` after review |

This repository does not ship an active Cursor `.cursor/mcp.json` and does not rely on undocumented `disabled` or `alwaysAllow` fields in Cursor MCP templates.

## MCP Packages

| MCP server | Package | Tested version | Registry latest checked | Default in public config |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.1.1` | Codex example disabled; sole Cursor minimal example, inactive until copied and credentialed |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | Codex example disabled; omitted from Cursor minimal example |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `2026.8.31` | Omitted from public minimal examples |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.4` | Omitted from public minimal examples |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.82` | Codex example disabled; omitted from Cursor minimal example |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.9.0` | Codex example disabled; omitted from Cursor minimal example |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | Omitted from public minimal examples |

Context7 `4.0.2` was verified against the [npm package metadata](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2) and the [official GitHub release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2) published on 2026-08-11. The package requires Node.js `>=20.18.1`. On Windows with Node.js `24.18.0`, the package reported the expected CLI version and options, completed a stdio `initialize` exchange for MCP protocol `2025-06-18`, and returned `resolve-library-id` and `query-docs` from `tools/list`.

This is package, static-configuration, and stdio-protocol evidence. It does not prove authenticated Context7 queries, real Codex/Cursor/Claude Code host integration, or business/production acceptance. Those higher evidence layers must be tested in the target client before being claimed.

All Codex/Cursor Context7 examples use the unversioned `@upstash/context7-mcp` package; other npm MCP invocations are also unpinned. The table's `4.0.2` remains a historical tested baseline, not proof that the version resolved by a future installation has been tested. Check the resolved version and runtime requirements before enabling it; consumers needing reproducible installs should pin their own verified version. Other servers remain routing candidates in `docs/mcp-routing.md` and should be added one at a time for a verified need rather than copied as a full catalog. The versions above remain compatibility evidence and must be re-checked before release.

## Optional Jev pilot

On 2026-09-21, a PowerShell synthetic preflight and 22 Python `3.13.12` standard-library evaluation requests on Windows called `https://api.typesafe.ai/v1/systemone` and returned `jev-1.13.0`; no SDK was installed. The [pilot report](jev-pilot.md) records 78 narrow judgments, a high-confidence false positive, deterministic checks and bounded Codex review. This is authenticated API evidence for this experiment, not native Skill-routing integration, calibrated accuracy, Chinese parity, future service/model compatibility, or production acceptance. Jev is optional and absent from default configurations and repository gates.

## Release Rule

Before tagging a release:

1. run `npm view <package> version` for each npm MCP package;
2. update the registry latest column if versions changed;
3. update tested versions only after re-verification;
4. keep every Context7 Codex/Cursor example on the unversioned package name; `scripts/validate.ps1` checks this policy and the bilingual historical version records;
5. leave npm MCP examples unpinned without an explicit `@latest` suffix; check the resolved version and do not treat registry latest as a tested version;
6. run `pwsh ./scripts/validate-release.ps1` to detect official Codex schema drift and strict-load the examples with the matching installed CLI;
7. document any tool-name or API-surface changes in the release notes.
