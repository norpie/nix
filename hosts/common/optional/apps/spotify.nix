{
  pkgs,
  inputs,
  spicetify-nix,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [spicetify-nix.nixosModule];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };

  environment.systemPackages = with pkgs; [
    spotify
  ];
}
