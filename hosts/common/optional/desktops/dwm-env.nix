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
              url = "https://github.com/norman-pkgs/dwm";
              rev = "f1a74da34ad636229726cb0bb4a6d7981a74fa04";
              sha256 = "sha256-2nKqXRpJpskDk6ZMGh/3HyvhSzthuivmoUuhoGvvA5g=";
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
