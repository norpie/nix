#!/usr/bin/env bash

# Interactive flake.lock selector using fzf
# Allows you to restore a previous working flake.lock

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKES_DIR="$SCRIPT_DIR/flakes"

# Check if flakes directory exists and has files
if [[ ! -d "$FLAKES_DIR" ]]; then
	echo "Error: $FLAKES_DIR directory not found"
	echo "Run ./auto-update-and-build.sh first to create successful builds"
	exit 1
fi

cd "$FLAKES_DIR"

# Get list of flake.lock files (excluding pre-update backups)
FLAKE_FILES=($(ls -t flake.lock.20* 2>/dev/null | grep -v 'pre-update' || true))

if [[ ${#FLAKE_FILES[@]} -eq 0 ]]; then
	echo "No saved flake.lock files found in $FLAKES_DIR"
	echo "Run ./auto-update-and-build.sh first to create successful builds"
	exit 1
fi

# Check if fzf is available
if ! command -v fzf &>/dev/null; then
	echo "Error: fzf is not installed"
	echo "Install it with: nix-shell -p fzf"
	exit 1
fi

# Create a formatted list with timestamps and file info
PREVIEW_CMD="cat '$FLAKES_DIR/{}' | head -20"

echo "Select a flake.lock to restore (newest first):"
echo "Current flake.lock will be backed up as flake.lock.backup"
echo ""

SELECTED=$(printf '%s\n' "${FLAKE_FILES[@]}" | fzf \
	--height=50% \
	--layout=reverse \
	--border \
	--preview="echo 'File: {}' && echo '' && stat -c 'Size: %s bytes | Modified: %y' '$FLAKES_DIR/{}' && echo '' && echo 'First 20 lines:' && $PREVIEW_CMD" \
	--preview-window=right:60% \
	--header="↑↓ navigate | Enter: select | Esc: cancel" \
	--prompt="Restore: ")

if [[ -n "$SELECTED" ]]; then
	# Backup current flake.lock
	if [[ -f "$SCRIPT_DIR/flake.lock" ]]; then
		cp "$SCRIPT_DIR/flake.lock" "$SCRIPT_DIR/flake.lock.backup"
		echo "✓ Backed up current flake.lock to flake.lock.backup"
	fi

	# Restore selected flake.lock
	cp "$FLAKES_DIR/$SELECTED" "$SCRIPT_DIR/flake.lock"
	echo "✓ Restored $SELECTED to flake.lock"
	echo ""
	echo "You can now run ./switch.sh to switch to this configuration"
else
	echo "No selection made"
	exit 1
fi
