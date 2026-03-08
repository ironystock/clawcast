# clawcast (OpenClaw Skill)

## Start here: Install from GitHub (agent-facing)

If your agent is not using ClawHub yet, install ClawCast directly from this GitHub repo.

Tell your OpenClaw agent:
1. "Clone `https://github.com/ironystock/clawcast` into my workspace skills folder as `skills/clawcast`."
2. "Run `./skills/clawcast/scripts/obs_target_switch.sh <obs-host-ip> 4455`."
3. "Run `./skills/clawcast/scripts/start_overlay_server.sh`."
4. "Run `./skills/clawcast/scripts/rebuild_scenes.sh`."
5. "Run `./skills/clawcast/scripts/smoke_test_walkthrough.sh`."

Reusable, boilerplate-first skill for helping OpenClaw agents stand up and automate OBS scenes for **any** project (streams, demos, recordings, walkthroughs).

## Install via chat (quickest path)

Use these chat instructions with your OpenClaw agent:

1. "Install the clawcast skill"
2. "Target OBS at `<obs-host-ip>:4455`"
3. "Run the clawcast baseline rebuild"
4. "Run a recording smoke walkthrough"

Equivalent CLI path:

```bash
# from workspace root
openclaw skills install clawcast
# then run scripts shown in Quick start below
```

## North star

This project is intentionally generic:
- no creator-specific branding required
- no fixed scene story required
- no dependency on one specific stream theme

Use defaults to bootstrap quickly, then customize scenes/sources for your own workflow.

## What it automates

- target local or remote OBS WebSocket hosts
- host overlay files over LAN-safe HTTP
- create/recreate a baseline scene pack
- apply transition defaults
- optional audio baseline tuning
- run recording smoke walkthroughs
- optional stream dry-run

## Prerequisites

- OBS Studio running with WebSocket enabled (default port `4455`)
- `mcporter` configured with an `obs` MCP server
- `python3`
- `sqlite3` (for OBS target switch script)
- `iproute2` (`ss`) for local server checks
- standard shell tools (`awk`, `grep`, `hostname`)

## Quick start

### Mode A: Installed as an OpenClaw skill

Run from your OpenClaw workspace root.

```bash
# 1) Point to target OBS host
./skills/clawcast/scripts/obs_target_switch.sh <obs-host-ip> 4455

# 2) Start local overlay server (serves workspace root)
./skills/clawcast/scripts/start_overlay_server.sh

# 3) Build baseline scenes + overlays
./skills/clawcast/scripts/rebuild_scenes.sh

# 4) Optional transition defaults
./skills/clawcast/scripts/apply_transition_preset.sh Fade 300

# 5) Optional audio baseline (set your own OBS input names)
export OBS_AUDIO_INPUTS="Mic/Aux,Desktop Audio"
./skills/clawcast/scripts/apply_audio_baseline.sh

# 6) Smoke recording walkthrough
./skills/clawcast/scripts/smoke_test_walkthrough.sh

# 7) Optional short streaming dry-run
./skills/clawcast/scripts/stream_dry_run.sh 15 "Intro" "Main Live"
```

### Mode B: Running from a cloned GitHub repo

Run from the cloned repo root.

```bash
# 1) Point to target OBS host
./scripts/obs_target_switch.sh <obs-host-ip> 4455

# 2) Start local overlay server (serves workspace root)
./scripts/start_overlay_server.sh

# 3) Build baseline scenes + overlays
./scripts/rebuild_scenes.sh

# 4) Optional transition defaults
./scripts/apply_transition_preset.sh Fade 300

# 5) Optional audio baseline
export OBS_AUDIO_INPUTS="Mic/Aux,Desktop Audio"
./scripts/apply_audio_baseline.sh

# 6) Smoke recording walkthrough
./scripts/smoke_test_walkthrough.sh

# 7) Optional short streaming dry-run
./scripts/stream_dry_run.sh 15 "Intro" "Main Live"
```

## Notes

- Installed mode defaults to overlays under `skills/clawcast/assets/overlays/`.
- Repo mode expects overlays under `assets/overlays/` in the cloned repo.
- For remote OBS, HTTP URLs are usually more reliable than `file://` local-file browser sources.
- You can replace baseline overlays with your own URLs/files after bootstrap.

## License

MIT
