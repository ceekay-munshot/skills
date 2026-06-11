#!/bin/bash
# Claude Code on the web - environment setup script.
#
# Installs every skill in this repo into ~/.claude/skills so cloud
# sessions on ANY repo load them at startup.
#
# How to use:
#   1. In claude.ai/code, open the environment settings dialog and paste
#      this script into the "Setup script" field.
#   2. Add an environment variable in the same dialog:
#        GH_TOKEN=<fine-grained PAT with read-only Contents access to
#                   ceekay-munshot/skills>
#      Note: env vars and setup scripts are visible to anyone who can
#      edit the environment. There is no dedicated secrets store yet.
#   3. Network access must be Trusted (default) or otherwise allow
#      github.com.
#
# Caching note: the environment snapshot is taken after this script runs
# and reused for later sessions, so skill updates pushed to the repo
# propagate only when the cache rebuilds (env settings change or ~7 day
# expiry).
set -u

SKILLS_REPO="ceekay-munshot/skills"
dest="$HOME/.claude/skills"
tmp="$(mktemp -d)"

if git clone --depth 1 "https://x-access-token:${GH_TOKEN}@github.com/${SKILLS_REPO}.git" "$tmp/skills"; then
  mkdir -p "$dest"
  for skill_md in "$tmp/skills"/*/SKILL.md; do
    [ -e "$skill_md" ] || continue
    skill_dir="$(dirname "$skill_md")"
    cp -R "$skill_dir" "$dest/"
    echo "Installed skill: $(basename "$skill_dir")"
  done
else
  echo "WARN: could not clone ${SKILLS_REPO}; skills not installed"
fi

rm -rf "$tmp"
# Never block session startup on a skill-sync failure.
exit 0
