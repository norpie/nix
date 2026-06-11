{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Float by class
      "float on, match:class dialog"
      "float on, match:class utility"
      "float on, match:class toolbar"
      "float on, match:class splash"
      "float on, match:class rustdesk"
      "float on, match:class Rustdesk"

      # Float by title
      "float on, match:title Voice Dictation"

      # Workspace assignments
      "workspace 1, match:title Entertainment"
      "workspace 2, match:class Spotify"
      "monitor DP-3, match:title Discord"
      "workspace 20 silent, match:title Discord"
      "workspace 4, match:class plexmediaplayer"
      "workspace 9, match:title qBittorrent"
    ];
  };
}
