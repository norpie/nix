{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Essentials
    git
    rsync
    unzip
    wget

    # Neovim
    neovim-nightly
    tree-sitter
    ripgrep

    # Language utilities
    alejandra
    clang
    jq
    gcc
    mold

    # Languages
    go
    nodejs
    cargo
    python3

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

  services.upower.enable = true;
}
