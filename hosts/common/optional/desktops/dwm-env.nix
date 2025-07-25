{
  pkgs,
  inputs,
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
    libinput = {
      enable = true;
      mouse = {
        middleEmulation = true;
        clickMethod = "buttonareas";
        disableWhileTyping = true;
        tapping = true;

        additionalOptions = ''
          Option "PalmDetection" "on"
          Option "TappingButtonMap" "lmr"
        '';
      };
    };
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
        sessionCommands = ''
            ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
            ! Catpuccin Mocha Xresources palette
            #define fg      #CDD6F4
            #define bg      #1E1E2E
            #define color0  #45475A
            #define color8  #585B70
            #define color1  #F38BA8
            #define color9  #F38BA8
            #define color2  #A6E3A1
            #define color10 #A6E3A1
            #define color3  #F9E2AF
            #define color11 #F9E2AF
            #define color4  #89B4FA
            #define color12 #89B4FA
            #define color5  #F5C2E7
            #define color13 #F5C2E7
            #define color6  #94E2D5
            #define color14 #94E2D5
            #define color7  #BAC2DE
            #define color15 #A6ADC8

            ! st
            st.foreground: fg
            st.background: bg
            st.color0:     color0
            st.color1:     color1
            st.color2:     color2
            st.color3:     color3
            st.color4:     color4
            st.color5:     color5
            st.color6:     color6
            st.color7:     color7
            st.color8:     color8
            st.color9:     color9
            st.color10:    color10
            st.color11:    color11
            st.color12:    color12
            st.color13:    color13
            st.color14:    color14
            st.color15:    color15

            ! dmenu
            dmenu.foreground:    fg
            dmenu.background:    bg
            dmenu.selforeground: bg
            dmenu.selbackground: fg

            ! dwm
            dwm.normfgcolor:     fg
            dwm.normbgcolor:     bg
            dwm.selfgcolor:      fg
            dwm.selbgcolor:      bg
            dwm.tagsnormfgcolor: fg
            dwm.tagsnormbgcolor: bg
            dwm.tagsselfgcolor:  fg
            dwm.tagsselbgcolor:  color4
          ''};
          ${pkgs.xorg.xmodmap}/bin/xmodmap "${pkgs.writeText "xkb-layout" ''
            ! Map `<>`-key to ctrl to mimic an ansi keyboard layout
            keycode 94 = Control_L
          ''}";
        '';
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
          # package = pkgs.dwm.overrideAttrs {
          #   src = pkgs.fetchgit {
          #     name = "dwm";
          #     url = "https://github.com/norpie/dwm";
          #     rev = "4ecd84c61252746a8f4c3e7d360eb05da8e583d0";
          #     sha256 = "sha256-QwUxotCfUq7wdrOD/LPvoYAHV2MhhJ8CjQvQrhmSXsU=";
          #   };
          # };
          package = inputs.dwm.packages.x86_64-linux.dwm-norpie;
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
    xprintidle

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
