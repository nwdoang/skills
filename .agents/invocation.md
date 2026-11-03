# Skill Invocation

Invocation mode is an intentional part of a skill's design.

## User-invoked

A user-invoked skill runs only when a user explicitly selects it. Use this mode when automatic selection would be surprising or unhelpful. Describe the explicit trigger in `SKILL.md` and set the harness policy in `agents/openai.yaml` when required.

## Model-invoked

A model-invoked skill may be selected automatically when its `SKILL.md` description matches the task. Its description must make both the trigger and important exclusions clear. Harness metadata should preserve implicit invocation.

Context Perimeter is model-invoked because it should automatically protect context use when an agent enters a monorepo or ambiguous multi-project workspace.
