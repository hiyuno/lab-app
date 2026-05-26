#!/usr/bin/env bash
# LeonTweets — setup y arranque en macOS
set -euo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
RESET="\033[0m"

ok()   { echo -e "${GREEN}✓${RESET} $*"; }
warn() { echo -e "${YELLOW}⚠${RESET}  $*"; }
fail() { echo -e "${RED}✗${RESET}  $*"; exit 1; }
info() { echo -e "${BOLD}→${RESET} $*"; }

echo ""
echo -e "${BOLD}LeonTweets — Setup${RESET}"
echo "─────────────────────────────────────"

# ── 1. macOS check ────────────────────────────────────────────────────────────
MACOS_VER=$(sw_vers -productVersion 2>/dev/null || echo "0")
MAJOR=$(echo "$MACOS_VER" | cut -d. -f1)
if [[ "$MAJOR" -lt 14 ]]; then
  fail "Requiere macOS 14 (Sonoma) o superior. Tienes: $MACOS_VER"
fi
ok "macOS $MACOS_VER"

# ── 2. Swift check ────────────────────────────────────────────────────────────
if ! command -v swift &>/dev/null; then
  warn "Swift no encontrado."
  info "Instalando Xcode Command Line Tools…"
  xcode-select --install 2>/dev/null || true
  echo ""
  echo "  Cuando termine la instalación, vuelve a ejecutar este script."
  exit 0
fi

SWIFT_VER=$(swift --version 2>&1 | head -1)
ok "Swift: $SWIFT_VER"

# ── 3. Ir al directorio de la app ─────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
ok "Directorio: $SCRIPT_DIR"

# ── 4. Build ──────────────────────────────────────────────────────────────────
info "Compilando LeonTweets…"
if swift build -c release 2>&1; then
  ok "Build exitoso (release)"
  BUILD_PATH=".build/release/LeonTweets"
else
  warn "Build release falló, intentando debug…"
  swift build 2>&1 || fail "Build fallido. Revisa los errores de arriba."
  BUILD_PATH=".build/debug/LeonTweets"
fi

# ── 5. Lanzar ─────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}Lanzando LeonTweets…${RESET}"
echo "─────────────────────────────────────"
echo "  Primera vez: abre ⌘, para configurar tus API keys"
echo "  • OpenAI o Grok (para interpretar letras)"
echo "  • Genius o Musixmatch (para buscar canciones)"
echo "  • X/Twitter — OAuth 1.0a (para publicar tweets)"
echo ""

open "$BUILD_PATH" 2>/dev/null || "$BUILD_PATH"
