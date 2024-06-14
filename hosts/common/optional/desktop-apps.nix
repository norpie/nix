{
  pkgs,
  configLib,
  ...
}: {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/apps/spotify.nix")
  ];

  environment.systemPackages = with pkgs; [
    mpv

    google-chrome

    obsidian

    teams-for-linux

    # discord + betterdiscordctl
    # `nix run nixpkgs#betterdiscordctl install` in nix form
    discord
    /*(discord.overrideAttrs (previousAttrs: {
      postInstall =
        (previousAttrs.postInstall)
        + ''
          ${pkgs.betterdiscordctl}/bin/betterdiscordctl install
        '';
    }))*/

    plex-media-player

    qbittorrent
  ];
}
