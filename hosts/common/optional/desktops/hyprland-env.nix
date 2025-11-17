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

  # add system packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk

    # idle
    wayland-pipewire-idle-inhibit

    # gui settings
    arandr

    # passive utilities
    libnotify
    dunst

    # temrinal
    alacritty-graphics

    # launcher
    rofi

    # utilities
    xdotool
    wev
    slurp
    grim
    satty

    # general utilities
    playerctl

    dictation-popup

    # clipboard
    wl-clipboard
    cliphist

    # desktop utilities
    dragon-drop

    # media
    vlc

    # xorg gui applications
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.koko
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
    hyprpicker

    zathura

    # status bar
    waybar

    # cursor theme
    vanilla-dmz
  ];
}
