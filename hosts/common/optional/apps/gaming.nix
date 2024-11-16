{pkgs, ...}: {
  # TODO: This v
  # https://github.com/mateusauler/nixos-config/blob/9234534867e50cef659997c67a5b71eb84e28670/home-manager-modules/scripts/steam-xdg.nix
  hardware.xpadneo.enable = true;
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
      extraPackages = with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    bottles
    lutris
    protonup
    protontricks
    prismlauncher
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/norpie/.local/data/steam/.steam/root/compatibilitytools.d";
  };
}
