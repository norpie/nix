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

    megasync
    bitwarden-desktop
    portfolio
    maltego

    obsidian

    teams-for-linux # TODO: Re-enable when it's fixed

    # discord + betterdiscordctl
    # `nix run nixpkgs#betterdiscordctl install` in nix form
    # discord
    /*
      (discord.overrideAttrs (previousAttrs: {
      postInstall =
        (previousAttrs.postInstall)
        + ''
          ${pkgs.betterdiscordctl}/bin/betterdiscordctl install
        '';
    }))
    */
    (pkgs.discord.override {
      # remove any overrides that you don't want
      withOpenASAR = true;
      withVencord = true;
    })

    plex-desktop

    qbittorrent
  ];

  programs = {
    firefox.enable = true;
  };
}
