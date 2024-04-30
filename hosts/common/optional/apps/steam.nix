{ ... }: {
    programs.steam = {
        enable = true;
        package = pkgs.steam-small.override {
            extraEnv = {
                HOME = "~/.local/data/steam";
            }
        };
    }
}
