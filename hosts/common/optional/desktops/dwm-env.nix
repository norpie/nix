{
  pkgs,
  configLib,
  lib,
  ...
}: {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/fonts.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/dmenu.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/st.nix")
  ];

  services = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = "norpie";
      };
    };
    picom = {
      enable = true;
    };
    xserver = {
      displayManager = {
        lightdm = {
          enable = true;
          greeter = {
            enable = true;
            name = "lightdm-webkit2-greeter";
          };
        };
      };
      enable = true;
      autorun = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      windowManager = {
        dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs {
            src = pkgs.fetchgit {
              name = "dwm";
              url = "https://github.com/norpie/dwm";
              rev = "12738b17603b0786c37154cbc87fff64640a3750";
              sha256 = "sha256-hjSrhCJ65l5jEf5dwE4IKC5BVHJxraUxH9G5OaA16DY=";
            };
          };
        };
      };
    };
  };

  services.xserver.windowManager.session =
    lib.singleton
    {
      name = "dwm";
      start = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        # on hostname: desktop load xrandr settings
        [[ $(hostname) == "desktop" ]] &&
            xrandr --output DP-2 --mode 1920x1080 --refresh 165.00 --primary --output DP-0 --mode 1920x1080 --left-of DP-2 --output DP-4 --mode 1920x1080 --right-of DP-2
        while true; do
          dwm & waitPID=$!
        done
      '';
    };

  # add system packages
  environment.systemPackages = with pkgs; [
    # gui settings
    arandr

    # passive utilities
    libnotify
    dunst

    # general utilities
    playerctl

    # xorg utilities
    xorg.xev
    xclip
    xdotool
    xsel
    xwallpaper
    numlockx
  ];
}
