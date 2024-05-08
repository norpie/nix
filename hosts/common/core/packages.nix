{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Essentials
    git
    rsync
    unzip
    wget
    zip

    # Improvements
    bat
    eza
    duf

    # Neovim
    neovim-nightly
    tree-sitter
    ripgrep

    # Flex
    fastfetch

    # Tools
    bottom
    btop
    ranger
    nvtopPackages.full

    # Tools
    nix-prefetch-scripts
    nix-output-monitor
    nix-index

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
