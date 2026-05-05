{...}: {
  home.sessionVariables = {
    # Locale
    LANG = "en_US.UTF-8";

    # QT theme
    QT_QPA_PLATFORMTHEME = "gtk2";

    # Mozilla touchscreen support
    MOZ_USE_XINPUT2 = "1";
  };

  # Bind Ctrl+D and 'e' alias to tmux_exit in SSH tmux sessions
  programs.fish.interactiveShellInit = ''
    if set -q TMUX; and set -q SSH_CONNECTION
        alias e tmux_exit
        alias q tmux_exit
        alias quit tmux_exit
    end
  '';
}
