#!/bin/bash
set -euo pipefail

# Only needed in remote (Claude Code on the web) sessions; local setups
# can clone this repo straight into ~/.claude/skills instead.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

repo_dir="${CLAUDE_PROJECT_DIR:?CLAUDE_PROJECT_DIR not set}"
dest="$HOME/.claude/skills"
mkdir -p "$dest"

# Every top-level directory containing a SKILL.md is a skill.
for skill_md in "$repo_dir"/*/SKILL.md; do
  [ -e "$skill_md" ] || continue
  skill_dir="$(dirname "$skill_md")"
  name="$(basename "$skill_dir")"
  mkdir -p "$dest/$name"
  cp -R "$skill_dir/." "$dest/$name/"
  echo "Installed skill: $name"
done
