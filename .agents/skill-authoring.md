# Skill Authoring

Use kebab-case for skill directory names. A production skill requires `SKILL.md` and `agents/openai.yaml`; add references, scripts, templates, or assets only when the workflow needs them.

`SKILL.md` is executable agent behavior: triggers, decisions, workflow, constraints, and failure boundaries. Human explanations, installation notes, and adoption guidance belong under `docs/<category>/<skill-name>.md`. Do not duplicate the full instructions in metadata or documentation.

Register promoted skills in `.claude-plugin/plugin.json`, add them to the category and root catalogs, then run repository validation.

Create a new skill when a concrete, repeatable problem has a distinct trigger and workflow that can stand on its own. Extend an existing skill when the behavior serves the same purpose and invocation context. Prefer skills observed in real engineering work; do not create skills for hypothetical problems merely to fill a catalog.
