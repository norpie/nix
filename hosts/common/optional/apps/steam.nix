{pkgs, ...}: {
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam-small {
        extraEnv = {
          HOME = "~/.local/data/steam";
        };
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
