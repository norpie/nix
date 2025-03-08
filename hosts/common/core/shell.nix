{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  environment.variables = {
    ZDOTDIR = "/home/norpie/.config/zsh";
  };
  environment.localBinInPath = true;
  programs.zsh = {enable = true;};
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  environment.systemPackages = with pkgs; [
    tmux
    fzf
    python312Packages.pygments
    ffmpegthumbnailer

    # Fun
    cowsay
    fortune
    lolcat
    figlet
    toilet
    sl
  ];
}
