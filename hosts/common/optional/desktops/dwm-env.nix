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
              rev = "7b230e9e1e06b7257a30b0b4235407da5ab5d5cc";
              sha256 = "sha256-NWDWiyE4NPiUX0RqLRnZB65pwH+1ymeOJjkUeC1weyA=";
            };
          };
        };
      };
    };
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
