{...}: {
  home.sessionVariables = {
    # Custom paths
    SCRIPT_DIR = "$HOME/.local/bin";
    STUDY = "$HOME/hs";
    REPO_DIR = "$HOME/repos";
  };

  # PATH additions
  home.sessionPath = [
    "$HOME/.local/share/spicetify"
    "$STUDY/.bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/cargo/bin"
    "$HOME/.local/bin/xroot-panels"
    "/usr/lib/jvm/default/bin"
    "/var/lib/flatpak/exports/bin"
    "$XDG_DATA_HOME/go/bin"
  ];
}
