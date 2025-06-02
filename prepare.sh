#!/usr/bin/env bash
bin_dir="$(dirname $0)/bins"

if [ -z "$(ls -A "$bin_dir" | grep -v .gitkeep)" ]; then
    echo "No binaries found in $bin_dir. Exiting."
    exit 0
fi

for bin in "$bin_dir"/*; do
    echo "Adding $bin to nix store"
    nix-store --add-fixed sha256 "$bin"
done
