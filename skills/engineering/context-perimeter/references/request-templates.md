# Scope request templates

Use these formats only when ambiguity or material scope expansion requires a user decision. Adapt them to the task and follow the host's authorization model; do not add a separate approval layer.

## Ambiguous primary project

```text
⚠ PROJECT SCOPE — PRIMARY PROJECT REQUIRED

I cannot determine the primary project for this task from the request, current working directory, or shallow workspace metadata.

Choose the primary project before I inspect project source.
```

## Material read-scope expansion

```text
⚠ PROJECT SCOPE — EXPANSION REQUIRED

Primary project:
<project>

Proposed read/search:
<exact path or narrow directory>

Question it will answer:
<question this access will answer>

Why this is a material expansion:
<why the location is not already part of the requested task>

Include this location in the task scope?
```

Direct dependency reads that are already necessary for the requested task do not use this template.

## Material cross-project write

```text
⚠ PROJECT SCOPE — WRITE EXPANSION

Primary project:
<project>

Requested write:
<exact file or files>

Reason:
<why this write is necessary and why it materially expands the task>

No other external files will be modified.

Include this write in the task scope?
```

## If access is denied

```text
The host or user denied access, so I will not inspect or infer the external implementation.

Unverified:
<specific fact>

I will continue with work that does not depend on that information. If it blocks completion, I will ask how you want to proceed.
```

## Example scope notes

```text
Primary: apps/hr
Additional paths included by the task:
- apps/shell/src/routes.ts

Targeted dependency reads:
- packages/ui/src/table/**

Material expansions confirmed:
- none
```

Keep these notes internal unless showing them helps the user understand a scope decision.
