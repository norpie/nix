{...}: {
  programs.fish.loginShellInit = ''
    # Set display variables from cache if available
    if test -f ~/.cache/display
        set -gx DISPLAY (cat ~/.cache/display)
    end
    if test -f ~/.cache/wayland_display
        set -gx WAYLAND_DISPLAY (cat ~/.cache/wayland_display)
    end
    if test -f ~/.cache/hyprland_instance
        set -gx HYPRLAND_INSTANCE_SIGNATURE (cat ~/.cache/hyprland_instance)
    end
  '';

  home.sessionVariables = {
    # Hardware acceleration (host-specific, but defined for desktop)
    # Note: Conditional on $HOST in original zsh config, keeping unconditional for now
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";

    # Wayland
    SDL_VIDEO_DRIVER = "wayland";

    # Webkit fix for tiling WMs
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
  };
}
