{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # General development tools
    gnumake
    entr

    # Language servers
    clang-tools_18
    emmet-ls
    gopls
    lua-language-server
    nil
    nodePackages_latest.bash-language-server
    nodePackages_latest.pyright
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest.vscode-css-languageserver-bin
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.vscode-json-languageserver
    taplo
    texlab
    yaml-language-server
    zls

    # Formatters
    alejandra
    shfmt
    stylua
    black
    prettierd

    # Language utilities
    clang
    jq
    gcc
    mold

    # Languages
    go
    nodejs
    cargo
    python3
  ];
}
