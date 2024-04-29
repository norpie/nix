{ pkgs, ... }: {
    users.defaultUserShell = pkgs.zsh;
    environment.variables = {ZDOTDIR = "/home/norpie/.config/zsh";};
    programs.zsh = {enable = true;};
    environment.systemPackages = with pkgs; [
        fzf
    ];
}
