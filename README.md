# skills

Personal Claude Code skills. Each top-level directory containing a
`SKILL.md` is one skill.

| Skill | Description |
| ----- | ----------- |
| `dashboard-builder` | Munshot standards for building embedded dashboards (3-zone iframe layout, WidgetCard, design tokens, Dashboard SDK auth, datasource registry). |

## How skills get loaded

### Cloud sessions on this repo

`.claude/settings.json` registers a SessionStart hook
(`.claude/hooks/session-start.sh`) that copies every `<skill>/SKILL.md`
directory into `~/.claude/skills/` when a web session starts on this
repo. Nothing to configure.

### Cloud sessions on ANY repo

Two options:

1. **claude.ai Skills (simplest).** Zip a skill folder (e.g.
   `dashboard-builder/` with `SKILL.md` at its top level) and upload it
   in claude.ai &rarr; Settings &rarr; Capabilities &rarr; Skills. Per the
   [Claude Code on the web docs](https://code.claude.com/docs/en/claude-code-on-the-web),
   skills enabled on claude.ai are loaded into cloud sessions
   automatically. Re-upload after editing a skill.

2. **Environment setup script.** Paste [`cloud-setup.sh`](cloud-setup.sh)
   into the environment's **Setup script** field and add a `GH_TOKEN`
   environment variable (fine-grained PAT, read-only Contents access to
   this repo). The script clones this repo and installs all skills into
   `~/.claude/skills/` before the session starts. See the comments in
   the script for caveats (token visibility, environment cache lag).

### Local machine

Clone this repo and copy (or symlink) the skill folders into
`~/.claude/skills/`.
