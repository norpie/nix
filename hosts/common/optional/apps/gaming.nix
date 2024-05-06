{pkgs, ...}: {
  # TODO: This v
  # https://github.com/mateusauler/nixos-config/blob/9234534867e50cef659997c67a5b71eb84e28670/home-manager-modules/scripts/steam-xdg.nix
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraProfile = ''
          export HOME=$HOME/.local/data/steam
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bottles
    lutris
    protonup
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/norpie/.local/data/steam/.steam/root/compatibilitytools.d";
  };
}
