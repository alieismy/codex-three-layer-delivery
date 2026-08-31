# AGENTS.md — Repository Maintainer Instructions

## Purpose and Authority

This file governs maintenance of the `codex-three-layer-delivery` source repository itself. It is not a distributable project template and must not become a current-task status record.

- `README.md` is the authority for repository purpose, the three-layer model, supported adapters, and published layout.
- The English root is the canonical baseline. `zh-CN/` is a translation pack; Claude and Cursor files are platform adapters that preserve documented platform differences.
- `codex/global/AGENTS.md` and `codex/project/AGENTS.md` are distributable templates. Do not make this maintainer file a byte-for-byte copy of either template.
- Detailed RD methods belong in the owning `skills/rd-*/SKILL.md`; this file keeps only repository-wide maintenance controls and pointers.

## Before Editing

- Inspect the user request, effective instructions, target file, authoritative English source, maintained mirrors, nearby references, and relevant validator entry points before changing content.
- Reuse previously inspected stable project context only when its authoritative source, revision, and applicability remain known. Use applicable low-cost change detectors such as branch and HEAD, worktree status, changed paths, and relevant source revisions to scope refreshes.
- Re-read affected or decision-critical sources after revision changes, external edits, new evidence, context compaction, task redirection, or conflicting observations. Do not rescan the entire repository by default, and do not claim prior context remains current without checking applicable change detectors.
- For complex or high-impact maintenance, briefly identify the reused baseline and newly refreshed dynamic evidence at the first meaningful checkpoint when that improves reviewability; do not impose a fixed context-accounting format on simple tasks.
- Treat versions, installed tools, external releases, generated configuration, runtime state, and test results as dynamic evidence. Recheck them when they affect a conclusion; keep version snapshots in `docs/compatibility.md`, not in this file.

## Change and Mirror Discipline

- Make the smallest coherent change and preserve unrelated content, encoding, LF line endings, terminology, numbering, and platform-specific behavior.
- Change the authoritative English source first, then synchronize Simplified Chinese and platform adapters where the same contract applies. Semantic parity is required; byte equality is required only where the validator explicitly defines it.
- Preserve invocation differences: Codex prompt examples use `$rd-*`; explicit Cursor and Claude Code examples use `/rd-*`; `rd-delivery` remains explicit-only.
- Keep one authoritative source for each rule, fact, decision, or workflow. Use resolvable pointers instead of copying detailed procedures into multiple always-loaded files.
- Use `.tmp/local/` for ignored task-local clones, downloads, logs, and probes. Do not place durable artifacts, credentials, or the only copy of evidence there.

## Dynamic Task State

- Keep current goals, progress, branch or commit snapshots, worktree and test results, known issues, failed approaches, and next actions in a task plan or delivery record, not in this file.
- This file may define when and where to read task state, but it must remain limited to durable repository rules. For explicit multi-stage document delivery, use the `rd-delivery` record as an index to authoritative artifacts rather than as a second content store.

## Value-First Maintenance

- Validate the shortest path to the requested outcome before expanding supporting work. Run low-cost tool, authentication, dependency, or entry-point preflights early when failure would invalidate the plan.
- Preserve applicable existing gates, but add a generalized validator, broad test matrix, security-hardening track, or framework only when required by the approved scope, an observed reproducible failure, an authoritative requirement, or a material risk. Otherwise record it as deferred with a re-entry trigger.
- If the primary path is blocked, report the blocker and resumable state instead of compensating with unrelated documentation, hardening, or tests. Peripheral completeness does not substitute for behavior, runtime, or user-outcome evidence.
- For agent instructions, prompts, Skill routing, or other behavior changes, run a focused behavior smoke test before broadening mirrors and support work when the environment permits it. Shared-surface changes still require the full repository gates before completion.

## Validation

Run the smallest sufficient checks, and run all repository gates when shared rules, mirrors, Skills, validators, compatibility data, or release contracts change:

```powershell
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
git diff --check
```

- A validator change must include a negative case that proves the affected invariant can fail.
- Static validation establishes repository shape and text contracts only. Do not claim Codex, Claude Code, Cursor, MCP, generated configuration, runtime, or business acceptance without the corresponding higher evidence layer.
- Before completion, inspect the full diff and confirm that intended mirrors, references, changelog entries, and validation descriptions remain consistent.

## Security, Git, and Release Boundary

- Do not add credentials, private endpoints, personal paths, account data, or unnecessary infrastructure identifiers to public templates, fixtures, logs, or documentation.
- Preserve user changes and keep staging explicit. Commit, push, pull-request mutation, merge, tag creation, and GitHub Release publication require explicit authority for those actions.
- Repository publication follows `docs/release-checklist.md`. A passing local validator does not itself authorize or prove a release.

## Completion Standard

Maintenance is complete only when the approved scope is implemented, authoritative and mirrored surfaces are consistent, applicable positive and negative validations pass, the final diff is clean and bounded, dynamic evidence is reported at its actual level, and unverified runtime or publication steps remain explicit.
