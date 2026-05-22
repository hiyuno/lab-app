#!/usr/bin/env bash
# Install Swift / iOS agent skills for Cursor (Lab App + optional app target).
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$LAB_APP_ROOT}"

echo "Lab App Swift agents installer"
echo "  Source: $LAB_APP_ROOT"
echo "  Target: $TARGET"

cd "$LAB_APP_ROOT"

if [[ -f .gitmodules ]]; then
  echo "→ Updating git submodules..."
  git submodule update --init --recursive
fi

install_skill_dir() {
  local src="$1"
  local name="$2"
  if [[ ! -d "$src" ]]; then
    echo "  skip $name (missing $src — run git submodule update --init)"
    return
  fi
  mkdir -p "$TARGET/.cursor/skills"
  rm -rf "$TARGET/.cursor/skills/$name"
  cp -R "$src" "$TARGET/.cursor/skills/$name"
  echo "  + $name"
}

echo "→ Installing Paul Hudson / twostraws skills..."
install_skill_dir "$LAB_APP_ROOT/external/SwiftUI-Agent-Skill/swiftui-pro" "swiftui-pro"
install_skill_dir "$LAB_APP_ROOT/external/Swift-Concurrency-Agent-Skill/swift-concurrency-pro" "swift-concurrency-pro"
install_skill_dir "$LAB_APP_ROOT/external/SwiftData-Agent-Skill/swiftdata-pro" "swiftdata-pro"

echo "→ Copying Lab App Swift wrapper skills..."
if [[ "$TARGET" != "$LAB_APP_ROOT" ]]; then
  mkdir -p "$TARGET/.cursor/skills"
  for skill in swift-agent-skills ios-dev-guide; do
    if [[ -d "$LAB_APP_ROOT/.cursor/skills/$skill" ]]; then
      rm -rf "$TARGET/.cursor/skills/$skill"
      cp -R "$LAB_APP_ROOT/.cursor/skills/$skill" "$TARGET/.cursor/skills/$skill"
      echo "  + $skill"
    fi
  done
else
  echo "  (wrappers already in Lab App)"
fi

echo ""
echo "Done. See process/SWIFT_AGENTS.md"
ls -1 "$TARGET/.cursor/skills/" 2>/dev/null | grep -E 'swift|ios' || true
