#!/usr/bin/env bash
bin_dir="$(dirname $0)/bins"

for bin in "$bin_dir"/*; do
    echo "Adding $bin to nix store"
    nix-store --add-fixed sha256 "$bin"
done
