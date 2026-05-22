#!/usr/bin/env bash
# Prepare an empty app folder for Director intake (platform + idea) before full bootstrap.
set -euo pipefail

LAB_APP_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GITHUB_ROOT="$(cd "$LAB_APP_ROOT/.." && pwd)"

usage() {
  echo "Usage: $0 <AppName>"
  echo "  Creates or updates $GITHUB_ROOT/<AppName>/ with intake rules only."
  echo "  Then open that folder in Cursor — Director asks platform + idea first."
  exit 1
}

[[ $# -eq 1 ]] || usage
APP_NAME="$1"

if [[ ! "$APP_NAME" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]; then
  echo "Error: AppName must be PascalCase alphanumeric."
  exit 1
fi

DEST="$GITHUB_ROOT/$APP_NAME"
TEMPLATE="$LAB_APP_ROOT/templates/intake-workspace"

mkdir -p "$DEST"
cp -R "$TEMPLATE/.cursor" "$DEST/" 2>/dev/null || mkdir -p "$DEST/.cursor/rules"
cp "$TEMPLATE/.cursor/rules/intake-first.mdc" "$DEST/.cursor/rules/"
mkdir -p "$DEST/docs" "$DEST/process"
cp "$TEMPLATE/docs/INTAKE.md" "$DEST/docs/"
cp "$TEMPLATE/README.md" "$DEST/README.md"
cp "$LAB_APP_ROOT/process/INTAKE.md" "$DEST/process/INTAKE.md"

# Replace placeholder in copied files
date_str="$(date +%Y-%m-%d)"
while IFS= read -r -d '' file; do
  if file "$file" | grep -q text; then
    sed -i '' -e "s/__APP_NAME__/$APP_NAME/g" -e "s/__DATE__/$date_str/g" "$file" 2>/dev/null || \
      sed -i -e "s/__APP_NAME__/$APP_NAME/g" -e "s/__DATE__/$date_str/g" "$file"
  fi
done < <(find "$DEST" -type f -print0)

echo "Intake workspace ready: $DEST"
echo ""
echo "Next:"
echo "  1. Open $DEST in Cursor (Agent mode)"
echo "  2. Director will ask: platform (iOS / macOS / both) + app idea"
echo "  3. After answers, from Lab App: ./scripts/new-app.sh $APP_NAME ios|macos"
