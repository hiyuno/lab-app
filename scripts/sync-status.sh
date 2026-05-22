#!/usr/bin/env bash
# Validate required process docs exist in an app repo.
set -euo pipefail

APP_ROOT="${1:-}"
if [[ -z "$APP_ROOT" ]]; then
  echo "Usage: $0 <path-to-app-repo>"
  exit 1
fi

if [[ ! -d "$APP_ROOT" ]]; then
  echo "Error: not a directory: $APP_ROOT"
  exit 1
fi

REQUIRED=(
  "AGENTS.md"
  "README.md"
  "docs/STATUS.md"
  "docs/KICKOFF.md"
  "docs/PRD.md"
  "docs/BACKLOG.md"
  "docs/ARCHITECTURE.md"
  "roles/director.md"
  ".cursor/rules/app-process.mdc"
)

MISSING=0
for f in "${REQUIRED[@]}"; do
  if [[ ! -f "$APP_ROOT/$f" ]]; then
    echo "MISSING: $f"
    MISSING=1
  else
    echo "OK: $f"
  fi
done

OPTIONAL=(
  "docs/COPY.md"
  "docs/SCREENS.md"
  "docs/QA.md"
)

echo ""
echo "Optional:"
for f in "${OPTIONAL[@]}"; do
  if [[ -f "$APP_ROOT/$f" ]]; then
    echo "OK: $f"
  else
    echo "—: $f"
  fi
done

if [[ $MISSING -eq 1 ]]; then
  exit 1
fi

echo ""
echo "All required process files present."
