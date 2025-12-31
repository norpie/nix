{...}: {
  wayland.windowManager.hyprland.settings = {
    # Permission for hyprpm
    permission = "/usr/(bin|local/bin)/hyprpm, plugin, allow";

    # Variables
    "$mod" = "SUPER";
    "$terminalraw" = "alacritty";
    "$terminal" = "alacritty -e tmux-session";
    "$menu" = "rofi -show drun";
    "$browser" = "firefox";

    # Environment variables
    env = [
      "XCURSOR_THEME,Vanilla-DMZ"
      "XCURSOR_SIZE,24"
    ];

    # Appearance
    general = {
      gaps_in = 5;
      gaps_out = 8;
      border_size = 0;
      "col.active_border" = "rgba(005577ee)";
      "col.inactive_border" = "rgba(444444aa)";
      layout = "master";
      allow_tearing = false;
    };

    decoration = {
      rounding = 5;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    # Layouts
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "slave";
      new_on_top = true;
      mfact = 0.50;
    };

    # Miscellaneous
    misc = {
      force_default_wallpaper = -1;
      disable_hyprland_logo = false;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    # Input configuration
    input = {
      kb_layout = "us";
      kb_variant = "";
      kb_model = "";
      kb_options = "caps:escape";
      kb_rules = "";
      follow_mouse = 1;

      touchpad = {
        natural_scroll = false;
      };

      touchdevice = {
        transform = -1;
        output = "[[Auto]]";
        enabled = true;
      };

      sensitivity = 0;
      accel_profile = "flat";
    };

    # Device-specific settings
    device = [
      {
        name = "logitech-g502-1";
        sensitivity = -0.5;
        accel_profile = "flat";
      }
      {
        name = "g-wolves-g-wolves-hsk-pro-8k-receiver-n";
        sensitivity = -0.7;
        accel_profile = "flat";
      }
      {
        name = "g-wolves-g-wolves-hsk-pro-8k-wireless-mouse-n";
        sensitivity = -0.7;
        accel_profile = "flat";
      }
      {
        name = "g-wolves-g-wolves-fenrir-pro-8k-receiver-n";
        sensitivity = -0.7;
        accel_profile = "flat";
      }
      {
        name = "g-wolves-g-wolves-fenrir-pro-8k-wireless-mouse-n";
        sensitivity = -0.7;
        accel_profile = "flat";
      }
    ];

    # Plugin configurations
    plugin = {
      touch_gestures = {
        sensitivity = 4.0;
        workspace_swipe_fingers = 3;
        workspace_swipe_edge = "d";
        long_press_delay = 400;
        resize_on_border_long_press = true;
        edge_margin = 10;

        hyprgrass-bind = [
          ", swipe:4:d, killactive"
          ", tap:3, exec, rofi -show drun"
          ", edge:r:l, workspace, +1"
          ", edge:l:r, workspace, -1"
        ];
      };

      hyprsplit = {
        num_workspaces = 9;
      };

      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "rgb(111111)";
        workspace_method = "first 1";
        skip_empty = true;
        gesture_distance = 300;
      };
    };
  };
}
