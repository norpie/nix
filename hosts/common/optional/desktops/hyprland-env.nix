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
    xdg-desktop-portal-gtk

    # gui settings
    arandr

    # passive utilities
    libnotify
    dunst

    # temrinal
    alacritty-graphics

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

    # xorg gui applications
    kdePackages.gwenview
    kdePackages.phonon
    kdePackages.phonon-vlc
    libsForQt5.phonon-backend-vlc
    libsForQt5.phonon-backend-gstreamer

    # gstreamer
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi

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
