#!/usr/bin/env bash
# Shared helpers: sync Lab App skills/rules to Cursor, Claude Code, and Antigravity.
set -euo pipefail

# Skills source of truth (Cursor layout)
lab_app_skills_source() {
  local lab_root="$1"
  echo "$lab_root/.cursor/skills"
}

# True if dest is the same directory as src (avoid rm+cp self-destruct).
skills_dirs_equal() {
  local a="$1" b="$2"
  [[ -d "$a" && -d "$b" ]] || return 1
  [[ "$(cd "$a" && pwd -P)" == "$(cd "$b" && pwd -P)" ]]
}

sync_skills_to_dir() {
  local src="$1"
  local dest_skills="$2"
  [[ -d "$src" ]] || return 0
  if skills_dirs_equal "$src" "$dest_skills"; then
    echo "skip"
    return 0
  fi
  mkdir -p "$dest_skills"
  local count=0 name
  for skill_dir in "$src"/*/; do
    [[ -d "$skill_dir" ]] || continue
    name="$(basename "$skill_dir")"
    rm -rf "$dest_skills/$name"
    cp -R "$skill_dir" "$dest_skills/$name"
    count=$((count + 1))
  done
  echo "$count"
}

sync_app_store_agents() {
  local lab_root="$1"
  local target="$2"
  local agents_src="$lab_root/.cursor/app-store-agents"
  [[ -d "$agents_src" ]] || return 0
  mkdir -p "$target/.claude/agents" "$target/.agents/agents"
  cp "$agents_src/"*.md "$target/.claude/agents/" 2>/dev/null || true
  cp "$agents_src/"*.md "$target/.agents/agents/" 2>/dev/null || true
}

patch_apple_app_review_paths() {
  local skill_file="$1"
  local agents_ref="$2"
  [[ -f "$skill_file" ]] || return 0
  sed -i '' "s|agents/|${agents_ref}|g" "$skill_file" 2>/dev/null || \
    sed -i "s|agents/|${agents_ref}|g" "$skill_file"
}

install_platform_context_files() {
  local lab_root="$1"
  local target="$2"
  local tpl="$lab_root/templates/platform"

  if [[ -f "$tpl/CLAUDE.md" ]]; then
    cp "$tpl/CLAUDE.md" "$target/CLAUDE.md"
  fi
  if [[ -f "$tpl/agents.md" ]]; then
    mkdir -p "$target/.agents"
    cp "$tpl/agents.md" "$target/.agents/agents.md"
  fi
  if [[ -f "$tpl/intake-workflow.md" ]]; then
    mkdir -p "$target/.agents/workflows"
    cp "$tpl/intake-workflow.md" "$target/.agents/workflows/intake-first.md"
  fi
}

sync_all_platform_skills() {
  local lab_root="$1"
  local target="$2"
  local src
  src="$(lab_app_skills_source "$lab_root")"
  [[ -d "$src" ]] || { echo "  skip skills (no .cursor/skills in Lab App)"; return; }

  local n
  mkdir -p "$target/.cursor/skills" "$target/.claude/skills" "$target/.agents/skills"

  n="$(sync_skills_to_dir "$src" "$target/.cursor/skills")"
  if [[ "$n" == "skip" ]]; then
    echo "  = .cursor/skills/ (source of truth, unchanged)"
  else
    echo "  + $n skills → .cursor/skills/"
  fi

  n="$(sync_skills_to_dir "$src" "$target/.claude/skills")"
  echo "  + $n skills → .claude/skills/"

  n="$(sync_skills_to_dir "$src" "$target/.agents/skills")"
  echo "  + $n skills → .agents/skills/"

  # Platform-specific agent path in apple-app-review router
  patch_apple_app_review_paths "$target/.claude/skills/apple-app-review/SKILL.md" ".claude/agents/"
  patch_apple_app_review_paths "$target/.agents/skills/apple-app-review/SKILL.md" ".agents/agents/"

  mkdir -p "$target/.cursor/app-store-agents"
  if [[ -d "$lab_root/.cursor/app-store-agents" ]]; then
    cp "$lab_root/.cursor/app-store-agents/"*.md "$target/.cursor/app-store-agents/" 2>/dev/null || true
    echo "  + app-store agents → .cursor/app-store-agents/"
  fi
  sync_app_store_agents "$lab_root" "$target"
  echo "  + app-store agents → .claude/agents/ and .agents/agents/"

  install_platform_context_files "$lab_root" "$target"
}

sync_platform_rules() {
  local lab_root="$1"
  local target="$2"
  mkdir -p "$target/.cursor/rules"
  cp "$lab_root/.cursor/rules/"*.mdc "$target/.cursor/rules/" 2>/dev/null || true
  echo "  + .cursor/rules/"
}
