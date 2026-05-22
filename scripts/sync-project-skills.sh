#!/usr/bin/env bash
# Copy skills and orchestrator docs to an app repo for Cursor, Claude Code, and Antigravity.
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$LAB_APP_ROOT}"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: target not found: $TARGET"
  exit 1
fi

# shellcheck source=lib/platform-sync.sh
source "$LAB_APP_ROOT/scripts/lib/platform-sync.sh"

echo "Sync skills (Cursor + Claude Code + Antigravity) → $TARGET"

mkdir -p "$TARGET/docs" "$TARGET/process"

sync_all_platform_skills "$LAB_APP_ROOT" "$TARGET"
sync_platform_rules "$LAB_APP_ROOT" "$TARGET"

# Orchestrator docs
for doc in SKILLS_REGISTRY.md APPSTORE_AGENTS.md DESIGN_AGENTS.md SWIFT_AGENTS.md PHASES.md HANDOFFS.md PLATFORMS.md; do
  if [[ -f "$LAB_APP_ROOT/process/$doc" ]]; then
    cp -f "$LAB_APP_ROOT/process/$doc" "$TARGET/process/$doc" 2>/dev/null || \
      cmp -s "$LAB_APP_ROOT/process/$doc" "$TARGET/process/$doc" 2>/dev/null || \
      cp "$LAB_APP_ROOT/process/$doc" "$TARGET/process/$doc"
  fi
done
echo "  + process/*.md"

if [[ -f "$LAB_APP_ROOT/templates/app-docs/SKILLS.md" ]]; then
  cp -f "$LAB_APP_ROOT/templates/app-docs/SKILLS.md" "$TARGET/docs/SKILLS.md" 2>/dev/null || \
    cp "$LAB_APP_ROOT/templates/app-docs/SKILLS.md" "$TARGET/docs/SKILLS.md"
  echo "  + docs/SKILLS.md"
fi

# Placeholder replacement when syncing into named apps
if [[ "$TARGET" != "$LAB_APP_ROOT" ]]; then
  app_name="$(basename "$TARGET")"
  date_str="$(date +%Y-%m-%d)"
  while IFS= read -r -d '' file; do
    if file "$file" | grep -q text; then
      sed -i '' -e "s/__APP_NAME__/$app_name/g" -e "s/__DATE__/$date_str/g" "$file" 2>/dev/null || \
        sed -i -e "s/__APP_NAME__/$app_name/g" -e "s/__DATE__/$date_str/g" "$file"
    fi
  done < <(find "$TARGET/CLAUDE.md" "$TARGET/.agents" -type f -print0 2>/dev/null || true)
fi

echo ""
echo "Done. Director: docs/STATUS.md → docs/SKILLS.md → process/SKILLS_REGISTRY.md"
echo "Platforms: .cursor/skills/ | .claude/skills/ | .agents/skills/ (see process/PLATFORMS.md)"
