#!/usr/bin/env sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

python3 - "$repo_root" <<'PY'
import json
import os
import sys

root = os.path.abspath(sys.argv[1])
errors = []

def repo_path(relative):
    return os.path.normpath(os.path.join(root, relative))

skills_root = repo_path("skills")
discovered = []
for current, dirs, files in os.walk(skills_root):
    dirs.sort()
    if "SKILL.md" in files:
        relative = os.path.relpath(current, root).replace(os.sep, "/")
        discovered.append(relative)
        if not os.path.isfile(os.path.join(current, "agents", "openai.yaml")):
            errors.append(f"{relative}: missing agents/openai.yaml")

manifest_path = repo_path(".claude-plugin/plugin.json")
try:
    with open(manifest_path, encoding="utf-8") as handle:
        manifest = json.load(handle)
except (OSError, json.JSONDecodeError) as exc:
    print(f"ERROR: cannot read .claude-plugin/plugin.json: {exc}", file=sys.stderr)
    sys.exit(1)

registered = manifest.get("skills", [])
if isinstance(registered, str):
    registered = [registered]
if not isinstance(registered, list) or not all(isinstance(path, str) for path in registered):
    errors.append(".claude-plugin/plugin.json: skills must be a string or array of strings")
    registered = []

normalized = [os.path.normpath(path[2:] if path.startswith("./") else path).replace(os.sep, "/") for path in registered]
duplicates = sorted({path for path in normalized if normalized.count(path) > 1})
for path in duplicates:
    errors.append(f"duplicate registered skill path: {path}")

for original, relative in zip(registered, normalized):
    absolute = repo_path(relative)
    if not os.path.exists(absolute):
        errors.append(f"registered path does not exist: {original}")
    elif not os.path.isfile(os.path.join(absolute, "SKILL.md")):
        errors.append(f"registered skill has no SKILL.md: {original}")

for relative in sorted(set(normalized)):
    parts = relative.split("/")
    if len(parts) == 3 and parts[0] == "skills":
        category, name = parts[1], parts[2]
        category_readme = repo_path(f"skills/{category}/README.md")
        root_readme = repo_path("README.md")
        for catalog in (category_readme, root_readme):
            try:
                with open(catalog, encoding="utf-8") as handle:
                    content = handle.read()
                if name not in content:
                    errors.append(f"{os.path.relpath(catalog, root)}: does not reference {name}")
            except OSError:
                errors.append(f"missing catalog: {os.path.relpath(catalog, root)}")

if errors:
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    sys.exit(1)

print(f"Validated {len(discovered)} skill package(s) and {len(normalized)} registered skill path(s).")
PY
