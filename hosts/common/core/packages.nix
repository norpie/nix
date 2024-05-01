{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Essentials
    git
    rsync
    unzip
    wget

    # Improvements
    bat
    eza
    duf

    # Neovim
    neovim-nightly
    tree-sitter
    ripgrep

    # Tools
    btop
    nvtopPackages.full

    # Tools
    nix-prefetch-scripts
    nix-output-monitor

    # Filesystems
    ntfs3g
    btrfs-progs
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/norpie/repos/nix";
  };
}
