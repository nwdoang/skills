# Repository Instructions

## Repository purpose

This is a public, multi-skill repository for reusable agent skills derived from real engineering work. Keep each skill independently understandable and portable across compatible harnesses.

## Current skill categories

- `engineering/`

Create a category only when an actual skill needs it.

## Skill requirements

A promoted skill must contain:

```text
SKILL.md
agents/openai.yaml
```

It should also have human documentation at `docs/<category>/<skill-name>.md`.

## Adding a skill

When adding a production skill:

1. Create `skills/<category>/<skill-name>/` using kebab-case.
2. Add its behavioral source of truth in `SKILL.md`.
3. Add concise OpenAI/Codex metadata in `agents/openai.yaml`.
4. Add human documentation under `docs/<category>/`.
5. Update the category README.
6. Update the root README.
7. Register the skill in `.claude-plugin/plugin.json`.
8. Run `scripts/validate-skills.sh`.

## Repository boundaries

Never add employer secrets, private company configuration, credentials, company-specific source code, internal-only URLs, proprietary documentation, or private architecture to this public repository.

## Architecture principle

Add infrastructure only for demonstrated needs. Do not introduce Changesets, package publishing, documentation generators, release frameworks, or large build systems without a concrete requirement.
