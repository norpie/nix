{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Essentials
    git
    git-lfs
    bc
    rsync
    wget
    unzip
    unrar
    p7zip
    zip

    # Improvements
    bat
    eza
    duf

    # Neovim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    tree-sitter
    ripgrep

    # Flex
    fastfetch

    # Tools
    bottom
    tree
    btop
    ranger
    yt-dlp
    nvtopPackages.full

    # Documents
    unoconv
    pandoc
    ffmpeg

    # Tools
    nix-prefetch-scripts
    nix-output-monitor
    nix-index

    # System utils
    pciutils
    usbutils

    # Filesystems
    cryptsetup
    ntfs3g
    btrfs-progs
  ];

  programs.appimage.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/norpie/repos/nix";
  };
}
