#!/usr/bin/env bash

# Copy SSH key for remote building if it exists
if [[ -f "$(dirname "$0")/keys/nixremote" ]]; then
    echo "Copying nixremote SSH key to /root/.ssh/"
    sudo mkdir -p /root/.ssh
    sudo cp "$(dirname "$0")/keys/nixremote" /root/.ssh/nixremote
    sudo chmod 600 /root/.ssh/nixremote
fi

NIXPKGS_ALLOW_INSECURE=1 nh os switch -- --impure || exit 1

# check if hyprland is running and reload it
if pgrep -x hyprland >/dev/null; then
    reload hyprland 
    reload waybar
fi
