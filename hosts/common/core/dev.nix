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
    # c/c++
    clang-tools
    # css
    emmet-ls
    # go
    gopls
    # lua
    lua-language-server
    #
    nil
    # bash
    nodePackages_latest.bash-language-server
    # python
    pyright
    # typescript
    nodePackages_latest.typescript-language-server
    # svelte
    nodePackages_latest.svelte-language-server
    # html, css, js
    vscode-langservers-extracted
    # toml
    taplo
    # latex
    texlab
    # yaml
    yaml-language-server
    # json
    zls
    # rust
    ra-multiplex
    rust-analyzer

    # Formatters
    alejandra
    shfmt
    stylua
    black
    prettierd

    # compilers
    clang
    gcc

    # linkers
    mold

    # package managers
    cargo

    # cli tools
    jq

    # Languages
    go
    nodePackages_latest.nodejs
    nodePackages_latest.npm
    python3
    python310
  ];
}
