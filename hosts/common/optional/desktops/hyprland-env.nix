{
  pkgs,
  configLib,
  ...
}: {
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
    hypridle = {
        enable = true;
    };
  };

  home-manager.users.norpie = {
      home.stateVersion = "25.05";
      wayland.windowManager.hyprland = {
          enable = true;
          extraConfig = "source = /home/norpie/.config/hypr/hyprland-actual.conf";

          plugins = with pkgs.hyprlandPlugins; [
            hyprgrass
            csgo-vulkan-fix
            hyprspace
            hyprsplit
          ];
      };
  };

  programs.waybar = {
    enable = true;
  };

  # add system packages
  environment.systemPackages = with pkgs; [
    hyprlandPlugins.hyprgrass
    hyprlandPlugins.csgo-vulkan-fix
    hyprlandPlugins.hyprspace
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

    # utilities
    xdotool

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
