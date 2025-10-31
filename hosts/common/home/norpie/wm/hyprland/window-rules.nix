{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Float by class
      "float,class:(dialog)"
      "float,class:(utility)"
      "float,class:(toolbar)"
      "float,class:(splash)"
      "float,class:(rustdesk)"
      "float,class:(Rustdesk)"

      # Float by title
      "float,title:(Voice Dictation)"

      # Workspace assignments
      "workspace 1,title:(Entertainment)"
      "workspace 2,class:(Spotify)"
      "workspace 2,title:(Discord)"
      "workspace 4,class:(plexmediaplayer)"
      "workspace 9,title:(qBittorrent)"
    ];
  };
}
