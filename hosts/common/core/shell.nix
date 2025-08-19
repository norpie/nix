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
    # long running processes
    tmux
    mprocs

    fzf
    python313Packages.pygments
    ffmpegthumbnailer

    # utils
    lsof
    pv
    speedtest-rs

    # non-browser web
    wiki-tui

    # network tools
    inetutils
    nmap
    whois

    # Improvements over coreutils
    ripgrep
    ripgrep-all
    bat
    eza
    duf
    fd
    zoxide
    dust
    dua

    # files
    ranger
    yazi

    # Tools
    bottom
    tree
    btop
    yt-dlp

    # Fun
    cowsay
    fortune
    lolcat
    figlet
    toilet
    sl
  ];
}
