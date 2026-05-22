#!/usr/bin/env bash
# Install or refresh design agent integrations for Cursor (Lab App + optional app target).
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$LAB_APP_ROOT}"

echo "Lab App design agents installer"
echo "  Source: $LAB_APP_ROOT"
echo "  Target: $TARGET"

cd "$LAB_APP_ROOT"

if [[ -f .gitmodules ]]; then
  echo "→ Updating git submodules..."
  git submodule update --init --recursive
fi

echo "→ Installing UI/UX Pro Max for Cursor..."
cd "$TARGET"
npx --yes uipro-cli@latest init --ai cursor

if [[ "$TARGET" != "$LAB_APP_ROOT" ]]; then
  echo "→ Copying design wrapper skills to app..."
  mkdir -p "$TARGET/.cursor/skills"
  for skill in design-with-claude libre-uiux; do
    if [[ -d "$LAB_APP_ROOT/.cursor/skills/$skill" ]]; then
      rm -rf "$TARGET/.cursor/skills/$skill"
      cp -R "$LAB_APP_ROOT/.cursor/skills/$skill" "$TARGET/.cursor/skills/$skill"
    fi
  done
fi

echo ""
echo "Done. Cursor skills in $TARGET/.cursor/skills/:"
ls -1 "$TARGET/.cursor/skills/" 2>/dev/null || true
echo ""
echo "See process/DESIGN_AGENTS.md for when the Director assigns each library."
