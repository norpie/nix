{
  pkgs,
  lib,
  configLib,
  ...
}: let
  vscode-insiders =
    (pkgs.vscode.override
      {
        isInsiders = true;
      })
    .overrideAttrs (oldAttrs: rec {
      src = builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        # sha256 = lib.fakeHash;
        sha256 = "0cnidqzh8j484kbnxbh4fgrjx2zl7wd2lfwyx9a4rhwkvrlhisx5";
      };
      version = "latest";

      buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
    });
in {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/apps/spotify.nix")
  ];

  environment.systemPackages = with pkgs; [
    mpv

    google-chrome

    # megasync
    bitwarden-desktop
    portfolio
    # maltego

    obsidian
    xournalpp

    # latest normal vscode
    vscode-insiders

    # db
    dbeaver-bin
    mariadb

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
    cinny-desktop
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
