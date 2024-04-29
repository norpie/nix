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
    discord

    qbittorrent
  ];
}
