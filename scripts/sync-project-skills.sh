#!/usr/bin/env bash
# Copy all Cursor skills, agents, and orchestrator docs to an app repo (or refresh Lab App).
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$LAB_APP_ROOT}"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: target not found: $TARGET"
  exit 1
fi

echo "Sync skills → $TARGET"

mkdir -p "$TARGET/.cursor/skills" "$TARGET/.cursor/app-store-agents" "$TARGET/docs" "$TARGET/process"

# All skills
if [[ -d "$LAB_APP_ROOT/.cursor/skills" ]]; then
  count=0
  for skill_dir in "$LAB_APP_ROOT/.cursor/skills"/*/; do
    [[ -d "$skill_dir" ]] || continue
    name="$(basename "$skill_dir")"
    rm -rf "$TARGET/.cursor/skills/$name"
    cp -R "$skill_dir" "$TARGET/.cursor/skills/$name"
    count=$((count + 1))
  done
  echo "  + $count skills → .cursor/skills/"
fi

# App Store agents
if [[ -d "$LAB_APP_ROOT/.cursor/app-store-agents" ]]; then
  cp "$LAB_APP_ROOT/.cursor/app-store-agents/"*.md "$TARGET/.cursor/app-store-agents/" 2>/dev/null || true
  echo "  + app-store agents"
fi

# Orchestrator docs
for doc in SKILLS_REGISTRY.md APPSTORE_AGENTS.md DESIGN_AGENTS.md SWIFT_AGENTS.md PHASES.md HANDOFFS.md; do
  if [[ -f "$LAB_APP_ROOT/process/$doc" ]]; then
    cp "$LAB_APP_ROOT/process/$doc" "$TARGET/process/$doc"
  fi
done
echo "  + process/*.md"

if [[ -f "$LAB_APP_ROOT/templates/app-docs/SKILLS.md" ]]; then
  cp "$LAB_APP_ROOT/templates/app-docs/SKILLS.md" "$TARGET/docs/SKILLS.md"
  echo "  + docs/SKILLS.md"
fi

# Rules
mkdir -p "$TARGET/.cursor/rules"
cp "$LAB_APP_ROOT/.cursor/rules/"*.mdc "$TARGET/.cursor/rules/" 2>/dev/null || true
echo "  + .cursor/rules/"

echo "Done. Director: read docs/STATUS.md, docs/SKILLS.md, process/SKILLS_REGISTRY.md"
