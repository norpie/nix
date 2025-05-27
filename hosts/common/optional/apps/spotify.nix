{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.comfy;
    colorScheme = "catppuccin-mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      loopyLoop
      powerBar
      seekSong
      skipStats
      songStats
      showQueueDuration
      copyToClipboard
      betterGenres
      savePlaylists
      playNext
      copyLyrics
      sectionMarker
      beautifulLyrics
      oneko
    ];
  };

  environment.systemPackages = with pkgs; [
    spotify
    ncspot
  ];
}
