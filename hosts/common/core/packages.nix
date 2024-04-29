{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
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
      rustup

      nix-prefetch-scripts
    ];
}
