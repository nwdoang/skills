# Optional persistent integration snippets

Context Perimeter works without repository instruction changes. Use these snippets only when the user explicitly asks to make it persistent for a monorepo or multi-project workspace.

Add the smallest equivalent rule to the instruction mechanism the current host already uses. Do not create or update every agent format.

## CLAUDE.md

```markdown
## AI project scope

Use the `context-perimeter` skill for development in this repository. Establish the primary project before broad source exploration, keep searches targeted, and make material expansion into unrelated projects explicit.

## project-structure

### Applications

- `apps/<project-a>` — <description>
- `apps/<project-b>` — <description>

### Shared packages

- `packages/<shared-a>` — <description>
- `packages/<shared-b>` — <description>
```

## AGENTS.md

```markdown
## AI project scope

Use the `context-perimeter` skill for development in this repository. Establish the primary project before broad source exploration, keep searches targeted, and make material expansion into unrelated projects explicit.

## project-structure

### Applications

- `apps/<project-a>` — <description>
- `apps/<project-b>` — <description>

### Shared packages

- `packages/<shared-a>` — <description>
- `packages/<shared-b>` — <description>
```

## Other agents

Use equivalent wording in the repository's existing instruction mechanism. Keep detailed behavior in the skill rather than duplicating it in the instruction file.

A `## project-structure` section is optional but useful when boundaries are stable and otherwise ambiguous. It lets agents identify projects without repeatedly inspecting workspace metadata.

If project boundaries are missing or unclear:

1. inspect only shallow directory names, project/workspace manifests, and workspace configuration;
2. draft the smallest accurate structure summary; and
3. modify the repository instruction file only when the user explicitly requested persistent integration.

Do not silently create or modify instruction files.
