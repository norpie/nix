#!/usr/bin/env bash

if [[ "$#" -eq 1 && "$1" -eq "wsl" ]]; then
    echo "Building WSL configuration..."
    sudo nix run .#nixosConfigurations.wsl.config.system.build.tarballBuilder
else
    echo "Building NixOS configuration..."
    NIXPKGS_ALLOW_INSECURE=1 nh os build -- --impure
fi
