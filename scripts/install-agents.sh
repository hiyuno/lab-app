#!/usr/bin/env bash
# Install all external agents (design + Swift + App Store) and sync to Cursor, Claude Code, and Antigravity.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-$ROOT}"
"$ROOT/scripts/install-design-agents.sh" "$TARGET"
"$ROOT/scripts/install-swift-agents.sh" "$TARGET"
"$ROOT/scripts/install-appstore-agents.sh" "$TARGET"
"$ROOT/scripts/sync-project-skills.sh" "$TARGET"
