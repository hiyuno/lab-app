#!/usr/bin/env bash
# Install App Store review + App Store Connect skills for Cursor.
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$LAB_APP_ROOT}"
REVIEW_SRC="$LAB_APP_ROOT/external/apple-app-review-skills"
ASC_SRC="$LAB_APP_ROOT/external/app-store-connect-skill"

echo "Lab App App Store agents installer"
echo "  Target: $TARGET"

cd "$LAB_APP_ROOT"
if [[ -f .gitmodules ]]; then
  echo "→ Updating git submodules..."
  git submodule update --init external/apple-app-review-skills external/app-store-connect-skill
fi

mkdir -p "$TARGET/.cursor/skills" "$TARGET/.cursor/app-store-agents"

install_review_skills() {
  if [[ ! -d "$REVIEW_SRC/skills" ]]; then
    echo "  skip review skills (submodule missing)"
    return
  fi
  echo "→ Installing apple-app-review-skills (31 checks)..."
  local count=0
  for category in layout permissions ugc privacy quality business metadata; do
    [[ -d "$REVIEW_SRC/skills/$category" ]] || continue
    for skill_dir in "$REVIEW_SRC/skills/$category"/*/; do
      [[ -d "$skill_dir" ]] || continue
      local name
      name="$(basename "$skill_dir")"
      rm -rf "$TARGET/.cursor/skills/$name"
      cp -R "$skill_dir" "$TARGET/.cursor/skills/$name"
      count=$((count + 1))
    done
  done
  echo "  + $count review skills"

  if [[ -f "$REVIEW_SRC/SKILL.md" ]]; then
    rm -rf "$TARGET/.cursor/skills/apple-app-review"
    mkdir -p "$TARGET/.cursor/skills/apple-app-review"
    cp "$REVIEW_SRC/SKILL.md" "$TARGET/.cursor/skills/apple-app-review/SKILL.md"
    sed -i '' 's|agents/|.cursor/app-store-agents/|g' "$TARGET/.cursor/skills/apple-app-review/SKILL.md" 2>/dev/null || \
      sed -i 's|agents/|.cursor/app-store-agents/|g' "$TARGET/.cursor/skills/apple-app-review/SKILL.md"
    echo "  + apple-app-review (router)"
  fi

  if [[ -d "$REVIEW_SRC/agents" ]]; then
    cp "$REVIEW_SRC/agents/"*.md "$TARGET/.cursor/app-store-agents/" 2>/dev/null || true
    echo "  + app-store agents → .cursor/app-store-agents/"
  fi

  if [[ -d "$REVIEW_SRC/references" ]]; then
    rm -rf "$TARGET/.cursor/skills/apple-app-review/references"
    cp -R "$REVIEW_SRC/references" "$TARGET/.cursor/skills/apple-app-review/references"
  fi
}

install_asc_skill() {
  if [[ ! -f "$ASC_SRC/SKILL.md" ]]; then
    echo "  skip app-store-connect (submodule missing)"
    return
  fi
  echo "→ Installing app-store-connect skill..."
  rm -rf "$TARGET/.cursor/skills/app-store-connect"
  mkdir -p "$TARGET/.cursor/skills/app-store-connect"
  cp "$ASC_SRC/SKILL.md" "$TARGET/.cursor/skills/app-store-connect/SKILL.md"
  [[ -d "$ASC_SRC/references" ]] && cp -R "$ASC_SRC/references" "$TARGET/.cursor/skills/app-store-connect/"
  [[ -d "$ASC_SRC/scripts" ]] && cp -R "$ASC_SRC/scripts" "$TARGET/.cursor/skills/app-store-connect/"
  if [[ -f "$ASC_SRC/config/credentials.local.md.example" ]]; then
    mkdir -p "$TARGET/.cursor/skills/app-store-connect/config"
    cp "$ASC_SRC/config/credentials.local.md.example" "$TARGET/.cursor/skills/app-store-connect/config/"
  fi
  echo "  + app-store-connect"
}

install_review_skills
install_asc_skill

if [[ "$TARGET" != "$LAB_APP_ROOT" ]]; then
  for skill in app-store-release; do
    if [[ -d "$LAB_APP_ROOT/.cursor/skills/$skill" ]]; then
      rm -rf "$TARGET/.cursor/skills/$skill"
      cp -R "$LAB_APP_ROOT/.cursor/skills/$skill" "$TARGET/.cursor/skills/$skill"
    fi
  done
fi

echo ""
echo "Done. See process/APPSTORE_AGENTS.md"
echo "App Store Connect: copy config/credentials.local.md.example → credentials.local.md (gitignored)"
