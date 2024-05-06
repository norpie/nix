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
    ranger
    nvtopPackages.full

    # Tools
    nix-prefetch-scripts
    nix-output-monitor

    # System utils
    pciutils

    # Filesystems
    ntfs3g
    btrfs-progs
  ];

  programs.nh = {
    enable = true;
    flake = "/home/norpie/repos/nix";
  };
}
