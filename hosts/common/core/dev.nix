{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # General development tools
    gnumake
    entr
    semver-tool
    pkg-config
    gperftools
    bruno
    websocat

    # Language servers
    clang-tools_18
    emmet-ls
    gopls
    lua-language-server
    nil
    nodePackages_latest.bash-language-server
    pyright
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

    # Libs
    libsodium
    openssl

    # Language utilities
    clang
    jq
    gcc13
    mold

    # Languages
    go
    nodePackages_latest.nodejs
    nodePackages_latest.npm
    rustup
    python3
    python310
  ];
}
