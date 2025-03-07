#!/usr/bin/env bash

[[ $1 -eq "wsl" ]] && sudo nix run .#nixosConfigurations.wsl.config.system.build.tarballBuilder && exit 0

NIXPKGS_ALLOW_INSECURE=1 nh os build -- --impure
