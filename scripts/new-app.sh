#!/usr/bin/env bash
# Scaffold a new iOS or macOS app as a sibling folder under Github/.
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GITHUB_ROOT="$(cd "$LAB_APP_ROOT/.." && pwd)"

usage() {
  echo "Usage: $0 <AppName> <ios|macos>"
  echo "  AppName: PascalCase, letters and numbers only (e.g. LabAppDemo)"
  echo "Creates: $GITHUB_ROOT/<AppName>/"
  exit 1
}

[[ $# -eq 2 ]] || usage

APP_NAME="$1"
STACK="$2"

if [[ ! "$APP_NAME" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]; then
  echo "Error: AppName must be PascalCase alphanumeric (e.g. MyApp)."
  exit 1
fi

if [[ "$STACK" != "ios" && "$STACK" != "macos" ]]; then
  echo "Error: stack must be ios or macos."
  exit 1
fi

DEST="$GITHUB_ROOT/$APP_NAME"

is_intake_only_workspace() {
  local dir="$1"
  [[ -d "$dir/docs" ]] || return 1
  [[ -f "$dir/docs/INTAKE.md" ]] || return 1
  # Not yet scaffolded: no Xcode project and no SwiftPM manifest
  [[ ! -d "$dir/${APP_NAME}.xcodeproj" ]] && [[ ! -f "$dir/Package.swift" ]]
}

if [[ -e "$DEST" ]]; then
  if is_intake_only_workspace "$DEST"; then
    echo "→ Scaffolding into existing intake workspace: $DEST"
    SCAFFOLD_INTO_EXISTING=true
  else
    echo "Error: destination already exists and is not intake-only: $DEST"
    echo "  Use a new name, remove the folder, or run init-workspace.sh for intake-only setup."
    exit 1
  fi
else
  SCAFFOLD_INTO_EXISTING=false
  mkdir -p "$DEST"
fi

replace_in_tree() {
  local root="$1"
  local date_str
  date_str="$(date +%Y-%m-%d)"

  # 1) Replace placeholders in file contents while paths are unchanged
  while IFS= read -r -d '' file; do
    if file "$file" | grep -q text; then
      sed -i '' \
        -e "s/__APP_NAME__/$APP_NAME/g" \
        -e "s/__DATE__/$date_str/g" \
        -e "s/__STACK__/$STACK/g" \
        "$file" 2>/dev/null || sed -i \
        -e "s/__APP_NAME__/$APP_NAME/g" \
        -e "s/__DATE__/$date_str/g" \
        -e "s/__STACK__/$STACK/g" \
        "$file"
    fi
  done < <(find "$root" -type f -print0)

  # 2) Rename directories (deepest first), then files (paths stay valid)
  while IFS= read -r -d '' old_path; do
    local new_path="${old_path//__APP_NAME__/$APP_NAME}"
    [[ "$old_path" != "$new_path" ]] && mv "$old_path" "$new_path"
  done < <(find "$root" -depth -type d -name '*__APP_NAME__*' -print0 2>/dev/null || true)

  while IFS= read -r -d '' old_path; do
    local new_path="${old_path//__APP_NAME__/$APP_NAME}"
    [[ "$old_path" != "$new_path" ]] && mv "$old_path" "$new_path"
  done < <(find "$root" -type f -name '*__APP_NAME__*' -print0 2>/dev/null || true)
}

copy_docs() {
  mkdir -p "$DEST/docs/decisions"
  cp "$LAB_APP_ROOT/templates/app-docs/"*.md "$DEST/docs/"
  cp "$LAB_APP_ROOT/templates/app-docs/README.md" "$DEST/README.md"
  replace_in_tree "$DEST"
}

copy_roles_and_cursor() {
  mkdir -p "$DEST/roles"
  cp "$LAB_APP_ROOT/roles/"*.md "$DEST/roles/"
  cp "$LAB_APP_ROOT/AGENTS.md" "$DEST/AGENTS.md"
  # All skills + orchestrator docs + rules
  "$LAB_APP_ROOT/scripts/sync-project-skills.sh" "$DEST"
}

echo "Creating $DEST ($STACK)..."

if [[ "${SCAFFOLD_INTO_EXISTING:-false}" != "true" ]]; then
  mkdir -p "$DEST"
fi

if [[ "$STACK" == "ios" ]]; then
  cp -R "$LAB_APP_ROOT/templates/ios-xcode/." "$DEST/"
  replace_in_tree "$DEST"
else
  cp -R "$LAB_APP_ROOT/templates/macos-swiftpm/." "$DEST/"
  replace_in_tree "$DEST"
fi

copy_docs
copy_roles_and_cursor

# Patch STATUS for scaffold phase
if [[ -f "$DEST/docs/STATUS.md" ]]; then
  sed -i '' \
    -e 's/1-kickoff/5-scaffold/' \
    -e 's/Fill `KICKOFF.md` objective and guardrails with human input./Verify build; then fill KICKOFF.md and move to phase 2-spec./' \
    "$DEST/docs/STATUS.md" 2>/dev/null || sed -i \
    -e 's/1-kickoff/5-scaffold/' \
    -e 's/Fill `KICKOFF.md` objective and guardrails with human input./Verify build; then fill KICKOFF.md and move to phase 2-spec./' \
    "$DEST/docs/STATUS.md"
fi

if [[ -f "$DEST/docs/KICKOFF.md" ]]; then
  sed -i '' "s/<!-- ios-xcode | macos-swiftpm -->/ios-xcode/" "$DEST/docs/KICKOFF.md" 2>/dev/null || true
  if [[ "$STACK" == "macos" ]]; then
    sed -i '' "s/ios-xcode/macos-swiftpm/" "$DEST/docs/KICKOFF.md" 2>/dev/null || \
      sed -i "s/ios-xcode/macos-swiftpm/" "$DEST/docs/KICKOFF.md"
  fi
fi

# App .gitignore
cat > "$DEST/.gitignore" <<'EOF'
.DS_Store
.build/
.swiftpm/
*.xcuserstate
xcuserdata/
DerivedData/
EOF

cd "$DEST"
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  git init -q
  git add -A
  git commit -q -m "chore: scaffold $APP_NAME from Lab App ($STACK)"
fi

if [[ "$STACK" == "ios" ]]; then
  echo "→ Installing App Store review skills (ios)..."
  "$LAB_APP_ROOT/scripts/install-appstore-agents.sh" "$DEST"
  cp "$LAB_APP_ROOT/roles/appstore-release.md" "$DEST/roles/" 2>/dev/null || true
fi

echo ""
echo "Created: $DEST"
echo "Next:"
echo "  1. Open $DEST in Cursor"
echo "  2. Edit docs/KICKOFF.md and docs/STATUS.md"
if [[ "$STACK" == "ios" ]]; then
  echo "  3. Open $APP_NAME.xcodeproj — set Development Team in Signing if build fails"
else
  echo "  3. Run: cd \"$DEST\" && swift build"
fi
echo "  4. Run: $LAB_APP_ROOT/scripts/sync-status.sh \"$DEST\""
