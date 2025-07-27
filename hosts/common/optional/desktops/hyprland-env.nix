{
  pkgs,
  configLib,
  inputs,
  lib,
  ...
}: 
let
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with hyprPluginPkgs; [
      # Add official plugins here as needed
    ];
  };
in {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/fonts.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/dmenu.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/st.nix")
  ];

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "norpie";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    HYPR_PLUGIN_DIR = hypr-plugin-dir;
  };

  # add system packages
  environment.systemPackages = with pkgs; [
    hyprlandPlugins.hyprgrass
    hyprlandPlugins.csgo-vulkan-fix
    hyprlandPlugins.hyprexpo
    hyprlandPlugins.hyprsplit

    # gui settings
    arandr

    # passive utilities
    libnotify
    dunst

    # temrinal
    alacritty

    # launcher
    rofi-wayland

    # general utilities
    playerctl

    # clipboard
    wl-clipboard
    cliphist

    # hypr*
    hyprpaper
    hyprlock
    hyprpolkitagent

    # cursor theme
    vanilla-dmz
  ];
}
