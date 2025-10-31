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
    WAKATIME_HOME = "$XDG_CONFIG_HOME/wakatime";
    DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
    STEAM_HOME = "$HOME/.local/data/steam";
    GOPATH = "$XDG_DATA_HOME/go";
    GOBIN = "$XDG_DATA_HOME/go/bin";
    GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
    GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
    VIMINIT = "source $XDG_CONFIG_HOME/nvim/init.lua";
    VIMDOTDIR = "source $XDG_CONFIG_HOME/nvim";
    VIMDIR = "$XDG_CONFIG_HOME/nvim";
    TEXMFVAR = "$XDG_CACHE_HOME/texlive/texmf-var";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    CARGO_HOME = "$HOME/.local/share/cargo";
    __GL_SHADER_DISK_CACHE_PATH = "$XDG_CONFIG_HOME/nvidia";
    XCOMPOSEFILE = "$XDG_CONFIG_HOME/X11/xcompose";
    XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
    USERXSESSION = "$XDG_CACHE_HOME/X11/xsession";
    USERXSESSIONRC = "$XDG_CACHE_HOME/X11/xsessionrc";
    ALTUSERXSESSION = "$XDG_CACHE_HOME/X11/Xsession";
    ERRFILE = "$XDG_CACHE_HOME/X11/xsession-errors";
    NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";
    NVM_DIR = "$XDG_CONFIG_HOME/nvm";
    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    SCREENRC = "$XDG_CONFIG_HOME/screen/screenrc";
    LEIN_HOME = "$XDG_DATA_HOME/lein";
    LESSHISTFILE = "$XDG_CACHE_HOME/less/history";
    TEXMFHOME = "$XDG_DATA_HOME/texmf";
    TEXMFCONFIG = "$XDG_CONFIG_HOME/texlive/texmf-config";
  };
}
