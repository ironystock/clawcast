# streaming-obs-bootstrap (OpenClaw Skill)

Reusable, boilerplate-first skill for helping OpenClaw agents stand up and automate OBS scenes for **any** project (streams, demos, recordings, walkthroughs).

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

Run from your OpenClaw workspace root.

```bash
# 1) Point to target OBS host
./skills/streaming-obs-bootstrap/scripts/obs_target_switch.sh <obs-host-ip> 4455

# 2) Start local overlay server (serves workspace root)
./skills/streaming-obs-bootstrap/scripts/start_overlay_server.sh

# 3) Build baseline scenes + overlays
./skills/streaming-obs-bootstrap/scripts/rebuild_scenes.sh

# 4) Optional transition defaults
./skills/streaming-obs-bootstrap/scripts/apply_transition_preset.sh Fade 300

# 5) Optional audio baseline (set your own OBS input names)
export OBS_AUDIO_INPUTS="Mic/Aux,Desktop Audio"
./skills/streaming-obs-bootstrap/scripts/apply_audio_baseline.sh

# 6) Smoke recording walkthrough
./skills/streaming-obs-bootstrap/scripts/smoke_test_walkthrough.sh

# 7) Optional short streaming dry-run
./skills/streaming-obs-bootstrap/scripts/stream_dry_run.sh 15 "Intro" "Main Live"
```

## Notes

- Defaults use skill-bundled overlays under `skills/streaming-obs-bootstrap/assets/overlays/`.
- For remote OBS, HTTP URLs are usually more reliable than `file://` local-file browser sources.
- You can replace baseline overlays with your own URLs/files after bootstrap.

## License

MIT
