{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      rsync
      unzip
      wget

      neovim-nightly

      alejandra
      clang
      jq
      gcc
      go
      mold
      nodejs
      cargo

      nix-prefetch-scripts

      ntfs3g
    ];
}
