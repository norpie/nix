{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # General development tools
    gnumake
    file
    semver-tool
    gperftools
    websocat
    perf
    tokei
    android-tools

    # auto runners
    entr
    bacon

    # http
    xh

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
    # nodePackages_latest.bash-language-server
    # python
    pyright
    # typescript
    # nodePackages_latest.typescript-language-server
    # svelte
    # nodePackages_latest.svelte-language-server
    # html, css, js
    vscode-langservers-extracted
    # tailwindcss
    tailwindcss-language-server
    # toml
    taplo
    # latex
    texlab
    # yaml
    yaml-language-server
    # json
    zls

    # Formatters
    alejandra
    shfmt
    stylua
    black
    # nodePackages_latest.prettier
    prettierd

    # linters
    actionlint

    # compilers
    clang
    gcc

    # linkers
    mold

    # cli tools
    jq

    # tui
    lazygit
    gitui
    delta
    gh
    gh-dash
    # opencode 

    wakatime-cli

    # ci/cd
    act

    # Languages
    go
    nodejs
    # nodePackages_latest.npm
    python3

    # Rust
    cargo

    # Libraries
    libclang
  ];
}
