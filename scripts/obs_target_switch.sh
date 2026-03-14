#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-localhost}"
PORT="${2:-4455}"
DB_ARG="${3:-}"
DB="${DB_ARG:-${AGENTIC_OBS_DB:-}}"

if [[ -z "$DB" ]]; then
  echo "ERROR: AGENTIC_OBS_DB is required (or pass DB path as arg 3)."
  echo "Example: AGENTIC_OBS_DB=\"$HOME/.agentic-obs/db.sqlite\" ./scripts/obs_target_switch.sh 192.168.1.50 4455"
  exit 1
fi

if [[ ! -f "$DB" ]]; then
  echo "ERROR: DB file not found: $DB"
  exit 1
fi

if [[ "${ALLOW_CROSS_COMPONENT_WRITE:-0}" != "1" ]]; then
  echo "ERROR: This script writes to an external agentic-obs DB."
  echo "Set ALLOW_CROSS_COMPONENT_WRITE=1 to confirm intentional config changes."
  exit 1
fi

sqlite3 "$DB" "update config set value='$HOST', updated_at=datetime('now') where key='obs_host';"
sqlite3 "$DB" "update config set value='$PORT', updated_at=datetime('now') where key='obs_port';"

echo "Updated agentic-obs target in $DB to $HOST:$PORT"
mcporter call 'obs.get_obs_status()'
