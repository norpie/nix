{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      rsync
      unzip
      wget

      # Neovim
      neovim-nightly
      tree-sitter

      alejandra
      clang
      jq
      gcc
      mold

      go
      nodejs
      cargo
      python3

      nix-prefetch-scripts

      ntfs3g
    ];

    services.upower.enable = true;
}
