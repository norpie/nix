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
    picom = {
      enable = true;
    };
    libinput.mouse.middleEmulation = false;
    xserver = {
      synaptics.accelFactor = 0;
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
        session =
          lib.singleton
          {
            name = "dwm";
            start = ''
              export _JAVA_AWT_WM_NONREPARENTING=1
              # on hostname: desktop load xrandr settings
              [[ $(hostname) == "desktop" ]] &&
                  xrandr --output DisplayPort-0 --mode 1920x1080 --refresh 165.00 --primary --output DisplayPort-1 --mode 1920x1080 --left-of DisplayPort-0 --output DisplayPort-2 --mode 1920x1080 --right-of DisplayPort-0
              dbus-update-activation-environment --all
              ssh-agent dwm & waitPID=$!
            '';
          };
        dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs {
            src = pkgs.fetchgit {
              name = "dwm";
              url = "https://github.com/norpie/dwm";
              rev = "4ecd84c61252746a8f4c3e7d360eb05da8e583d0";
              sha256 = "sha256-QwUxotCfUq7wdrOD/LPvoYAHV2MhhJ8CjQvQrhmSXsU=";
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

    # xorg gui applications
    sxiv
    zathura

    # desktop utilities
    flameshot
    xdragon

    # xorg utilities
    xorg.xev
    xclip
    xdotool
    xsel
    xwallpaper
    numlockx
  ];
}
