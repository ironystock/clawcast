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
# 1) Target OBS host (explicit write acknowledgement + DB path required)
ALLOW_CROSS_COMPONENT_WRITE=1 AGENTIC_OBS_DB="$HOME/.agentic-obs/db.sqlite" \
  ./skills/clawcast/scripts/obs_target_switch.sh <obs-host-ip> 4455

# 2) Start/verify overlay host server (serves skill directory only)
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
- Baseline-required overlays live in `assets/overlays/`.
- Optional project-specific examples live in `examples/project-specific/`.
- Avoid `/tmp` for persistent assets.
- For remote OBS, prefer HTTP browser source URLs over `file://`.

## Security & transmission

- No API keys/tokens are required by default for this skill.
- OBS control uses the configured WebSocket endpoint (default port `4455`).
- Overlay pages are served over local HTTP (`:8787`) and should remain on trusted LAN/VPN.
- `start_overlay_server.sh` serves only the skill directory (not workspace root).
- `obs_target_switch.sh` requires `AGENTIC_OBS_DB` + `ALLOW_CROSS_COMPONENT_WRITE=1` to confirm intentional cross-component config writes.
- Do not expose OBS WebSocket or overlay HTTP ports publicly.

## References

- `references/scene-map.md`
- `references/networking.md`
- `references/troubleshooting.md`
- `references/v0.2-features.md`
