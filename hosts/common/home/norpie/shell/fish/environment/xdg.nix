{...}: {
  home.sessionVariables = {
    # XDG Base Directories
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_DATA_DIRS = "$HOME/.local/share:/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_LOCAL_BIN = "$HOME/.local/bin";
    XDG_DATA_GAMES = "$HOME/.local/share/games";
    XDG_DOWNLOADS_HOME = "$HOME/Downloads";

    # XDG Compliance for various tools
    WAKATIME_HOME = "$HOME/.config/wakatime";
    DOCKER_CONFIG = "$HOME/.config/docker";
    STEAM_HOME = "$HOME/.local/data/steam";
    GOPATH = "$HOME/.local/share/go";
    GOBIN = "$HOME/.local/share/go/bin";
    GOMODCACHE = "$HOME/.cache/go/mod";
    GRADLE_USER_HOME = "$HOME/.local/share/gradle";
    VIMINIT = "source $HOME/.config/nvim/init.lua";
    VIMDOTDIR = "source $HOME/.config/nvim";
    VIMDIR = "$HOME/.config/nvim";
    TEXMFVAR = "$HOME/.cache/texlive/texmf-var";
    GNUPGHOME = "$HOME/.local/share/gnupg";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    CARGO_HOME = "$HOME/.local/share/cargo";
    __GL_SHADER_DISK_CACHE_PATH = "$HOME/.config/nvidia";
    XCOMPOSEFILE = "$HOME/.config/X11/xcompose";
    XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
    USERXSESSION = "$HOME/.cache/X11/xsession";
    USERXSESSIONRC = "$HOME/.cache/X11/xsessionrc";
    ALTUSERXSESSION = "$HOME/.cache/X11/Xsession";
    ERRFILE = "$HOME/.cache/X11/xsession-errors";
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NVM_DIR = "$HOME/.config/nvm";
    CUDA_CACHE_PATH = "$HOME/.cache/nv";
    SCREENRC = "$HOME/.config/screen/screenrc";
    LEIN_HOME = "$HOME/.local/share/lein";
    LESSHISTFILE = "$HOME/.cache/less/history";
    TEXMFHOME = "$HOME/.local/share/texmf";
    TEXMFCONFIG = "$HOME/.config/texlive/texmf-config";
  };
}
