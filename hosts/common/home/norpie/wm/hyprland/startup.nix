{...}: {
  wayland.windowManager.hyprland.settings = {
    # Autostart commands (run once at startup)
    exec-once = [
      "/home/norpie/.config/hypr/init.sh"
      "wayland-pipewire-idle-inhibit"
      "hyprpaper"
      "hyprpolkitagent"
      "hypridle"
      "hyprsunset"
      "wl-paste --watch cliphist store"
      "reload hyprland"
    ];

    # Commands to run on every config reload
    exec = [
      "monitor layout default"
      "reload waybar"
    ];
  };
}
