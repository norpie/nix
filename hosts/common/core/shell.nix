{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  environment.variables = {
    ZDOTDIR = "/home/norpie/.config/zsh";
  };
  environment.localBinInPath = true;
  programs.zsh = {enable = true;};
  programs.command-not-found.enable = true;
  environment.systemPackages = with pkgs; [
    fzf
  ];
}
