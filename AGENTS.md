# AGENTS.md

This file provides guidance to Agents on how to interact with Norpie's NixOS configuration repository. It includes an overview of the repository structure, key commands for building and switching configurations, and details about application configuration locations.

## Repository Overview

This is Norpie's personal NixOS configuration repository using Nix flakes. It manages multiple host configurations with a modular architecture.

## Key Commands

### Building and Switching
- YOU ARE NOT ALLOWED TO SWITCH/BUILD, YOU CAN ONLY SUGGEST THAT THE USER DOES IT USING THE FOLLOWING COMMANDS: `./build.sh` and `./switch.sh` scripts are provided for building and switching the NixOS configuration on the current host.

### Development and Testing
- `nix flake check` - Validate flake configuration
- `nix run .#install` - Run the installation script
- `nix develop` - Enter development shell (if devShell is defined)

### Hyprland and Waybar
- `reload` - Reload both Hyprland and Waybar configurations (preferred over `hyprctl reload` and `killall -SIGUSR2 waybar`)

## Architecture

### Flake Structure
- **flake.nix**: Main flake configuration defining inputs, outputs, and host configurations
- **flake.lock**: Lock file for reproducible builds
- **lib/default.nix**: Helper functions, notably `relativeToRoot` for path resolution

### Host Configurations
The repository supports multiple host systems defined in `flake.nix`:

- **jupiter**: Main desktop/workstation configuration 
- **venus**: Secondary host configuration
- **mars**: Another host configuration
- **wsl**: Windows Subsystem for Linux configuration
- **vm**: Virtual machine configuration

Each host has its own directory in `hosts/` with:
- `configuration.nix`: Main host-specific configuration
- `hardware.nix`: Hardware-specific settings
- Additional service configurations (e.g., `syncthing.nix`, `tailscale.nix`)

### Common Configuration
- **hosts/common/**: Shared configuration modules
  - `core/`: Essential system configurations
  - `optional/`: Optional feature modules
  - `users/`: User-specific configurations

### Key Inputs
- `nixpkgs`: NixOS packages (using unstable channel)
- `home-manager`: User environment management
- `nixos-wsl`: WSL-specific modules
- `hardware`: Hardware-specific configurations
- `sops-nix`: Secrets management
- Custom suckless builds (`dwm`, `st`, `dmenu`)
- `hyprland`: Wayland compositor
- `spicetify-nix`: Spotify theming

## Important Notes

- Uses `NIXPKGS_ALLOW_INSECURE=1` flag for certain packages
- Builds are performed with `--impure` flag
- The configuration uses `nixos-unstable` channel
- Installation is available via `curl -L nix.norpie.dev | sh`

## File Patterns

- Host configurations: `hosts/{hostname}/configuration.nix`
- Common modules: `hosts/common/{core,optional,users}/`
- Build scripts: `*.sh` files in root
- Nix files: `*.nix` throughout the repository

## Application Configuration Locations

### Config files in ~/.config/
Core applications with configuration files:
- **hypr/**: Hyprland window manager config
- **waybar/**: Status bar configuration
- **alacritty/**: Terminal emulator
- **nvim/**: Neovim editor config
- **tmux/**: Terminal multiplexer
- **zsh/**: Shell configuration (environment.zsh, functions.zsh, etc.)
- **git/**: Git configuration
- **ssh/**: SSH client config
- **rofi/**: Application launcher
- **dunst/**: Notification daemon
- **mpv/**: Video player
- **zathura/**: PDF reader
- **fontconfig/**: Font configuration
- **fastfetch/**: System info tool
- **yazi/**: File manager
- **bat/**: Better cat with syntax highlighting
- **btop/**: System monitor
- **lazygit/**: Git TUI
- **ranger/**: File manager
- **ncspot/**: Spotify TUI client
- **qBittorrent/**: Torrent client
- **discord/**: Discord client
- **obs-studio/**: Streaming/recording software
- **vlc/**: Media player
- **spotify/**: Spotify client (with spicetify theming)

### Programs configured via Nix
- **firefox**: Browser (configured via programs.firefox)
- **spicetify**: Spotify theming (configured via programs.spicetify)
- **direnv**: Environment management (configured via programs.direnv)
- **nh**: Nix helper (configured via programs.nh)

### Shell aliases and environment
Key shell aliases from zsh config:
- Text editors: `vim`→`nvim`, `v`→`vim`, `sim`→`sudo vim`
- System tools: `top`→`btop`, `cat`→`bat`, `ls`→`eza`, `df`→`duf`
- Git shortcuts: `g`→`git`, `lg`→`lazygit`, `gs`→`git status -s`
- System control: `sys`→`sudo systemctl`, `usys`→`systemctl --user`
