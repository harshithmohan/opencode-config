#!/usr/bin/env bash
# Installs this opencode config onto a target system.
# This repo is the source of truth; run this after cloning on a new machine.
# Usage: ./install.sh [--dry-run]
set -euo pipefail

DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    *) echo "Unknown option: $arg (usage: $0 [--dry-run])" >&2; exit 1 ;;
  esac
done

DEST="${HOME}/.config/opencode"
SRC="$(cd "$(dirname "$0")" && pwd)"

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

run mkdir -p "$DEST/commands"
run cp "$SRC/config/"* "$DEST/"
run cp "$SRC/commands/"* "$DEST/commands/"

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run complete — no files were changed. Would install to $DEST"
else
  echo "Installed opencode config to $DEST"
fi
