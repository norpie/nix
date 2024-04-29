{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      unzip
      wget

      neovim-nightly

      alejandra
      clang
      gcc
      go
      mold
      nodejs
      rustup

      nix-prefetch-scripts
    ];
}
