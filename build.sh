#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prepare binaries (add requireFile packages to nix store)
"$SCRIPT_DIR/prepare.sh"

if [[ "$#" -eq 1 && "$1" -eq "wsl" ]]; then
	echo "Building WSL configuration..."
	sudo nix run .#nixosConfigurations.wsl.config.system.build.tarballBuilder
else
	echo "Building NixOS configuration..."
	NIXPKGS_ALLOW_INSECURE=1 nh os build -- --impure
fi
