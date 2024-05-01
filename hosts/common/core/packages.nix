{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Essentials
      git
      rsync
      unzip
      wget

      # Neovim
      neovim-nightly
      tree-sitter

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
      nix-prefetch-scripts

      # Filesystems
      ntfs3g
      btrfs-progs
    ];

    services.upower.enable = true;
}
