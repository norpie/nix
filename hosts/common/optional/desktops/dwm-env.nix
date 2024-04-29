{ pkgs, configLib, ... }: {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/fonts.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/dmenu.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/st.nix")
  ];

  services.xserver = {
    enable = true;
    autorun = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = pkgs.fetchgit {
          name = "dwm";
          url = "https://github.com/norman-pkgs/dwm";
          rev = "07fe725120aded9a281f69d4ed8643acd1f442dc";
          sha256 = "sha256-l65iJ6NMIrorSViPI/myf+gaFTUfU4dHkqLcxR/z7sE=";
        };
      };
    };
  };

  # add system packages
  environment.systemPackages = with pkgs; [
    # gui settings
    arandr

    # passive utilities
    picom
    libnotify
    dunst

    # general utilities
    playerctl
    btop

    # xorg utilities
    xclip
    xdotool
    xsel
    xwallpaper
    numlockx
  ];

  services.getty.autologinUser = "norpie";
}
