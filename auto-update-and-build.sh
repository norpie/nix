#!/usr/bin/env bash

# Automatic flake update and build script
# This script is meant to be run by cron every 3 days
# It updates flake.lock, builds the config, and stores successful builds

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKES_DIR="$SCRIPT_DIR/flakes"
LOG_FILE="$SCRIPT_DIR/auto-build.log"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)

# Function to log with timestamp
log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Ensure we're in the right directory
cd "$SCRIPT_DIR" || exit 1

# Truncate log to only keep the latest run
: >"$LOG_FILE"

log "=========================================="
log "Starting automatic update and build"
log "=========================================="

# Create flakes directory if it doesn't exist
mkdir -p "$FLAKES_DIR"

# Backup current flake.lock before updating
if [[ -f flake.lock ]]; then
	cp flake.lock "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP"
	log "Backed up current flake.lock"
fi

# Update flake.lock
log "Running nix flake update..."
if nix flake update 2>&1 | tee -a "$LOG_FILE"; then
	log "Flake update successful"
else
	log "ERROR: Flake update failed"
	# Restore previous flake.lock
	if [[ -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" ]]; then
		mv "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" flake.lock
		log "Restored previous flake.lock"
	fi
	exit 1
fi

# Try to build
log "Running build..."
if ./build.sh 2>&1 | tee -a "$LOG_FILE"; then
	log "Build successful!"

	# Store the successful flake.lock
	cp flake.lock "$FLAKES_DIR/flake.lock.$TIMESTAMP"
	log "Stored successful flake.lock as: flake.lock.$TIMESTAMP"

	# Remove the pre-update backup
	rm -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP"

	# Keep only the last 10 successful builds
	cd "$FLAKES_DIR"
	ls -t flake.lock.20* 2>/dev/null | tail -n +11 | xargs -r rm
	log "Cleaned up old builds (keeping last 10)"

	log "=========================================="
	log "Build completed successfully"
	log "=========================================="
	exit 0
else
	log "ERROR: Build failed"

	# Restore previous flake.lock
	if [[ -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" ]]; then
		mv "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" flake.lock
		log "Restored previous flake.lock"
	fi

	log "=========================================="
	log "Build failed - keeping previous working build"
	log "=========================================="
	exit 1
fi
