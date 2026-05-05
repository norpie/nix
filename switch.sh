#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKES_DIR="$SCRIPT_DIR/flakes"

# Parse arguments
UPDATE_FLAKE=false
for arg in "$@"; do
	case $arg in
	--update)
		UPDATE_FLAKE=true
		shift
		;;
	*)
		# Unknown option, pass through to nh
		;;
	esac
done

# If --update flag is set, run flake update
if [[ "$UPDATE_FLAKE" == "true" ]]; then
	echo "Running nix flake update..."
	nix flake update
fi

# Prepare binaries (add requireFile packages to nix store)
"$SCRIPT_DIR/prepare.sh"

# Copy SSH key for remote building if it exists
if [[ -f "$SCRIPT_DIR/keys/nixremote" ]]; then
	echo "Copying nixremote SSH key to /root/.ssh/"
	sudo mkdir -p /root/.ssh
	sudo cp "$SCRIPT_DIR/keys/nixremote" /root/.ssh/nixremote
	sudo chmod 600 /root/.ssh/nixremote
fi

# Perform the switch
echo "Switching to new configuration..."
NIXPKGS_ALLOW_INSECURE=1 nh os switch -- --impure "$@"

echo "✓ Successfully switched to new configuration"
