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
    configType = "hyprlang";

    plugins = with pkgs.hyprlandPlugins; [
      hyprgrass
      hyprsplit
    ];
  };
}
