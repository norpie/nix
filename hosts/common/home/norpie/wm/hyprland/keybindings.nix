{...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Application launchers
      "$mod, SPACE, exec, rofi -show run"
      "$mod SHIFT, SPACE, exec, rofi -show run -run-command 'sudo {cmd}'"

      # Rofi utilities
      "$mod, A, exec, rofi-appimage"
      "$mod, G, exec, rofi-steam"
      "$mod, I, exec, rofi-insert"
      "$mod, O, exec, rofi-output"
      "$mod, D, exec, rofi-drag"

      # Bluetooth
      "$mod, B, exec, rofi-bluetooth-connect"
      "$mod SHIFT, B, exec, rofi-bluetooth-disconnect"

      # System
      "$mod, R, exec, /home/norpie/.local/bin/dictation-launch"
      "$mod SHIFT, R, exec, rofi-restart"
      "$mod, F4, exec, rofi-power"

      # Terminal
      "$mod, RETURN, exec, $terminal"

      # Brightness
      ", XF86MonBrightnessUp, exec, brightness -i 5"
      ", XF86MonBrightnessDown, exec, brightness -d 5"

      # Application shortcuts
      "$mod, C, exec, $browser"
      "$mod, S, exec, $terminalraw -e tmux new-session -A -s ncspot ncspot"
      "$mod, W, exec, wallpaper --gui"
      "$mod, P, exec, gtklp"
      "$mod, M, exec, rofi-mount"
      "$mod, U, exec, rofi-unmount"

      # Clipboard management
      "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "$mod SHIFT, V, exec, cliphist wipe"
      "$mod SHIFT, S, exec, screenshot"
      "$mod SHIFT, P, exec, hyprpicker-rofi"

      # Window management
      "$mod, Q, killactive,"
      "$mod SHIFT, C, exit,"
      "$mod, F, exec, toggle-fullscreen"
      "$mod SHIFT, F, togglefloating,"

      # Move focus
      "$mod, K, movefocus, d"
      "$mod, L, movefocus, u"
      "$mod, J, movefocus, l"
      "$mod, semicolon, movefocus, r"

      # Move window to monitor
      "$mod SHIFT, J, movewindow, mon:l"
      "$mod SHIFT, semicolon, movewindow, mon:r"

      # Workspaces
      "$mod, 1, split:workspace, 1"
      "$mod, 2, split:workspace, 2"
      "$mod, 3, split:workspace, 3"
      "$mod, 4, split:workspace, 4"
      "$mod, 5, split:workspace, 5"
      "$mod, 6, split:workspace, 6"
      "$mod, 7, split:workspace, 7"
      "$mod, 8, split:workspace, 8"
      "$mod, 9, split:workspace, 9"

      # Move to workspace
      "$mod SHIFT, 1, split:movetoworkspacesilent, 1"
      "$mod SHIFT, 2, split:movetoworkspacesilent, 2"
      "$mod SHIFT, 3, split:movetoworkspacesilent, 3"
      "$mod SHIFT, 4, split:movetoworkspacesilent, 4"
      "$mod SHIFT, 5, split:movetoworkspacesilent, 5"
      "$mod SHIFT, 6, split:movetoworkspacesilent, 6"
      "$mod SHIFT, 7, split:movetoworkspacesilent, 7"
      "$mod SHIFT, 8, split:movetoworkspacesilent, 8"
      "$mod SHIFT, 9, split:movetoworkspacesilent, 9"

      # Explore
      "$mod CONTROL, SPACE, hyprexpo:expo, toggle"

      # Additional dwm-like bindings
      "$mod, TAB, workspace, previous"
      "$mod SHIFT, P, layoutmsg, swapwithmaster"

      # Scroll through existing workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Media keys
      ", XF86AudioRaiseVolume, exec, volume -i 5"
      ", XF86AudioLowerVolume, exec, volume -d 5"
      ", XF86AudioMute, exec, volume -m"
      ", XF86AudioPlay, exec, media play-pause"
      ", XF86AudioPause, exec, media pause"
      ", XF86AudioStop, exec, media stop"
      ", XF86AudioNext, exec, media next"
      ", XF86AudioPrev, exec, media previous"
    ];

    # Mouse bindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
