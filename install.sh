#!/usr/bin/env bash
# Installs this opencode config onto a target system.
# This repo is the source of truth; run this after cloning on a new machine.
set -euo pipefail

DEST="${HOME}/.config/opencode"
SRC="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$DEST/commands"
cp "$SRC/config/"* "$DEST/"
cp "$SRC/commands/"* "$DEST/commands/"
echo "Installed opencode config to $DEST"
