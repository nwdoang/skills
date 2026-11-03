---
name: context-perimeter
description: Govern context and file exploration in monorepos or multi-project workspaces by establishing a stable primary project, using targeted searches, and making material scope expansion explicit. Use when a task targets one app or package inside a larger repository, when workspace boundaries are ambiguous, or when broad scans could load unrelated code. Do not use for ordinary single-project work where the relevant boundary is already clear.
license: MIT
metadata:
  author: nwdoang
  version: "0.1.0"
  repository: "https://github.com/nwdoang/skills"
---

# Context Perimeter

Keep repository exploration proportional to the task. In a monorepo or multi-project workspace, establish one primary project for the current task and avoid loading unrelated projects into context.

This is context governance, not an authorization or security boundary. System and developer instructions, the host's permission model, and the user's request take precedence. Do not invent an additional approval layer or use this skill to bypass an existing one.

The guiding question is: **is this information necessary to complete or verify the current task?** Prefer a known file, specific symbol, targeted search, or relevant documentation section over a repository-wide scan.

## Bootstrap scope when the skill activates

1. Read the repository instructions that the current host already treats as applicable.
2. Read only the workspace metadata needed to understand likely project boundaries.
3. Use a project or path explicitly named in the user's request as the primary project.
4. Otherwise, if the current working directory clearly belongs to one project, use it without asking.
5. If boundaries are undocumented, inspect only shallow directory names, workspace manifests, project manifests, and workspace configuration needed to identify them.
6. If multiple plausible primary projects remain, ask the user which one is primary before inspecting project source.
7. After selecting the primary project, read any applicable project-specific instructions.

A root instruction file and a `## project-structure` section can make this faster, but neither is required for one-off use. Do not create or modify repository instructions merely because the skill is active.

## Preserve scope for the current task

Keep the primary project stable while completing the current task. Mentioning or reading a dependency does not replace it.

Re-establish scope when:

- the user starts a materially different task;
- the user explicitly selects another primary project; or
- prior scope state is unavailable or unreliable.

The nearest Git root is the repository boundary, not necessarily the project boundary. Prefer the smallest project that contains the requested work. A task may legitimately span multiple projects when the user's requested outcome includes them.

Track only context that affects decisions:

- the primary project;
- additional paths the user included in the task;
- targeted dependency or shared-package reads used to complete or verify it;
- any material scope expansion the user confirmed.

Do not turn these notes into a separate permission ledger.

## Explore selectively inside the primary project

READ and SEARCH are allowed automatically inside the primary project after scope is established.

Start with the smallest useful operation:

1. Search for filenames, symbols, imports, routes, configuration keys, or error text tied to the request.
2. Open the most relevant files and follow concrete references from them.
3. Broaden the search inside the primary project only when a focused search leaves a specific question unanswered.

Prefer targeted tools and explicit paths:

| Avoid when the scope is `apps/hr` | Prefer |
|---|---|
| `rg "Employee" .` | `rg "Employee" apps/hr` |
| `rg --files .` | `rg --files apps/hr` |
| `git grep "Employee"` | `git grep "Employee" -- apps/hr` |
| repository-wide `git log` or `git diff` | `git log -- apps/hr` or `git diff -- apps/hr` |

Listings and search results also consume context. Do not recursively enumerate the whole repository merely to become familiar with it.

Repository-level configuration needed to understand or validate the primary project may be read selectively, including workspace manifests, base configuration, lint configuration, applicable repository instructions, and relevant root documentation. Do not sweep an entire documentation directory.

## Cross-project reads

When another project, sibling package, or shared library is directly relevant to completing or verifying the requested task, read or search the narrowest useful location. This does not require a separate approval prompt when the user's request and the host's permission model already allow the read.

Examples include following a concrete import, checking an exposed type, locating an existing shared component, or verifying a directly affected integration boundary.

Ask before proceeding when the proposed read would materially expand the task, such as:

- scanning an unrelated application;
- enumerating several sibling projects without a focused question; or
- opening a broad external directory based only on speculation.

When asking, state the exact file or narrowest useful directory and the question it will answer. Use [references/request-templates.md](references/request-templates.md) when a visible scope-expansion request would help.

If the host or user denies access, do not infer or invent the external implementation. State what remains unverified and continue with work that is still possible.

## Shared packages and reuse

Avoid both indiscriminate shared-package scans and needless duplicate implementations. Before introducing a reusable component, hook, utility, helper, type abstraction, asset, or infrastructure primitive:

1. Identify the most likely shared location from manifests, imports, or documented structure.
2. Search that location narrowly when reuse is directly relevant to the task.
3. Reuse a suitable implementation when it meets the task's needs.
4. Create a local implementation when no suitable shared option exists, access is unavailable, or reuse would create poor coupling.

The reuse rule never justifies scanning all shared packages.

## Writes

A user request to change behavior authorizes the files reasonably necessary to complete that change, subject to the host's permission model. Do not ask for redundant per-file WRITE approval.

Keep edits proportional to the requested outcome. A cross-project write is in scope when the user names that resource or when it is a clear and necessary part of the requested multi-project outcome. Ask before a write that would materially or surprisingly expand the task into another project.

Reading another project never by itself authorizes modifying it. Do not persist Context Perimeter activation by creating or changing repository instruction files unless the user explicitly asks for that integration.

## Git operations

Git operations that expose source content or history should remain scoped to the primary project and task-relevant resources.

Prefer:

```text
git diff -- apps/hr
git log -- apps/hr
git blame apps/hr/src/example.ts
git show <commit> -- apps/hr
```

Metadata-oriented operations such as `git status --short` may be used normally, but their output does not justify reading unrelated changed files.

## Build, test, lint, and typecheck

Prefer project-scoped commands:

```text
turbo test --filter=hr
nx test hr
pnpm --filter hr test
```

Expected traversal of direct workspace dependencies is normal and does not require a separate permission prompt. Avoid commands that unnecessarily build or execute the entire workspace. If a command would cause a material expansion or external side effect beyond the requested task, follow the host's authorization rules and ask when required.

When a change spans multiple projects, validate each affected project in proportion to risk.

## Lockfiles, generated paths, and heavy directories

Avoid loading entire lockfiles. When dependency resolution data is needed, use a targeted search in `pnpm-lock.yaml`, `package-lock.json`, `yarn.lock`, `bun.lock`, or the relevant lockfile without adding a separate approval prompt.

Do not inspect dependency, cache, VCS-internal, build, coverage, or generated directories by default, including `node_modules/`, `.git/`, `dist/`, `build/`, `coverage/`, `.next/`, `.turbo/`, and `.nx/`.

Generated files produced by the current task inside its scope are normal. Inspect pre-existing generated code only when it is needed to complete or verify the task.

## Delegation

When the host supports delegation, pass the primary project, task-relevant additional paths, and expected write scope to the worker. Delegation must not turn a targeted investigation into a repository-wide scan.

## Report scope honestly

When scope affects confidence, briefly state what was inspected and what remained unverified. Do not claim repository-wide confidence from project-scoped evidence.

## Optional persistent activation

The skill works without modifying repository instruction files. Only when the user explicitly asks to make Context Perimeter persistent for a repository, read [references/integration-snippets.md](references/integration-snippets.md) and add the smallest host-appropriate activation rule and optional project-structure summary.
