# Agent Skills

Reusable AI agent skills developed from concrete software-engineering workflows and recurring problems. Each skill is an independent package with its own executable instructions and harness metadata.

## Available skills

| Skill | Category | Purpose |
| --- | --- | --- |
| [context-perimeter](skills/engineering/context-perimeter/SKILL.md) | Engineering | Restricts repository exploration to the active project and explicitly relevant or approved boundaries. |

## Installation

### Claude Code plugin

Add this repository as a marketplace, then install its skill collection:

```sh
claude plugin marketplace add nwdoang/skills
claude plugin install nwdoang-skills@nwdoang-skills
```

### Individual skill

Agent Skills-compatible installers can select a single skill from the repository. With the skills CLI:

```sh
npx skills add https://github.com/nwdoang/skills --skill context-perimeter
```

## Repository structure

- `skills/` contains the actual skill packages.
- `docs/` contains human-facing documentation.
- `.agents/` defines repository and skill-authoring conventions.
- `.claude-plugin/` contains Claude Code distribution metadata.
- `scripts/` contains small repository maintenance tools.
- `.github/` contains contribution templates and CI automation.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This repository is licensed under the [MIT License](LICENSE).
