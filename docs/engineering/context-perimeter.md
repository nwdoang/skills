# Context Perimeter

## What it does

Context Perimeter keeps an agent's repository exploration proportional to the task. It identifies the active project, favors targeted reads and searches, and avoids pulling unrelated projects into the working context.

## When to use it

Use it in monorepos, multi-project workspaces, or repositories whose project boundaries are unclear. It is unnecessary for a straightforward single-project repository with an obvious scope.

## How it behaves

The skill selects the smallest project that contains the requested work, permits task-relevant root configuration and shared dependencies, and follows concrete references rather than scanning broadly. The current working directory can establish scope when it clearly belongs to one project.

## Scope escalation

Directly relevant dependency reads are normal. The agent asks before a speculative or material expansion into unrelated projects and identifies the narrow location and question it wants to investigate. Explicitly named or approved paths remain available to the task.

## Limitations

Context Perimeter governs context use; it is not a security boundary and does not replace user instructions, host permissions, or normal authorization requirements. Focused inspection may leave unrelated repository behavior unverified.

## Expected result

Agents should use less irrelevant context, avoid unnecessary repository-wide scans, and report the limits of project-scoped evidence honestly.
