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

  # add system packages
  environment.systemPackages = with pkgs; [
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
    wev
    slurp

    # general utilities
    playerctl

    # clipboard
    wl-clipboard
    cliphist

    # desktop utilities
    gscreenshot
    xdragon

    # hypr*
    hyprpaper
    hyprlock
    hyprpolkitagent
    hyprsunset

    # status bar
    waybar

    # cursor theme
    vanilla-dmz
  ];
}
