{pkgs, ...}: {
  imports = [
    ./colors.nix
    ./settings.nix
    ./keybindings.nix
    ./window-rules.nix
    ./startup.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hyprgrass
      hyprexpo
      hyprsplit
    ];
  };
}
