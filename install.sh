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
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

run mkdir -p "$DEST/commands"
run cp "$SRC/config/"* "$DEST/"
run cp "$SRC/commands/"* "$DEST/commands/"
# Copy subfolder configs (e.g. opencode-quota/)
if [ -d "$SRC/config/opencode-quota" ]; then
  run mkdir -p "$DEST/opencode-quota"
  run cp "$SRC/config/opencode-quota/"* "$DEST/opencode-quota/"
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run complete — no files were changed. Would install to $DEST"
else
  echo "Installed opencode config to $DEST"
fi
