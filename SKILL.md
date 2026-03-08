---
name: clawcast
description: Bootstrap and automate OBS scenes for local or remote instances via agentic-obs + mcporter. Use when an OpenClaw agent needs to create a reusable baseline scene pack, wire browser/media sources over LAN-safe HTTP, run recording/stream smoke tests, and provide a clean starting point for project-specific customization.
---

# ClawCast

Use this skill to create a generic, reusable OBS automation baseline.

## Prerequisites

- `mcporter` installed/configured with `obs` MCP server
- OBS WebSocket enabled on target OBS host (default `4455`)
- `python3`, `sqlite3`, `ss` (iproute2), and standard shell tools

## Workflow

1. Switch target OBS host
2. Start overlay HTTP server
3. Rebuild baseline scene pack from skill assets
4. Optionally apply transition + audio defaults
5. Run recording smoke walkthrough
6. Optionally run stream dry-run

## Commands

```bash
# 1) Target OBS host
./skills/clawcast/scripts/obs_target_switch.sh <obs-host-ip> 4455

# 2) Start/verify overlay host server
./skills/clawcast/scripts/start_overlay_server.sh

# 3) Rebuild baseline scenes + overlays
./skills/clawcast/scripts/rebuild_scenes.sh

# 4) Apply transition preset
./skills/clawcast/scripts/apply_transition_preset.sh Fade 300

# 5) Optional audio baseline
# export OBS_AUDIO_INPUTS="Mic/Aux,Desktop Audio"
./skills/clawcast/scripts/apply_audio_baseline.sh

# 6) Run walkthrough recording
./skills/clawcast/scripts/smoke_test_walkthrough.sh

# 7) Optional stream dry-run
./skills/clawcast/scripts/stream_dry_run.sh 15 "Intro" "Main Live"
```

## Notes

- This skill is boilerplate-first; customize scenes and assets after bootstrap.
- Avoid `/tmp` for persistent assets.
- For remote OBS, prefer HTTP browser source URLs over `file://`.

## References

- `references/scene-map.md`
- `references/networking.md`
- `references/troubleshooting.md`
- `references/v0.2-features.md`
