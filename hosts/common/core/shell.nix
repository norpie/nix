{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  environment.variables = {
    ZDOTDIR = "/home/norpie/.config/zsh";
  };
  environment.localBinInPath = true;
  environment.pathsToLink = [
    "/home/norpie/.local/bin/"
  ];
  programs.zsh = {enable = true;};
  environment.systemPackages = with pkgs; [
    fzf
  ];
}
