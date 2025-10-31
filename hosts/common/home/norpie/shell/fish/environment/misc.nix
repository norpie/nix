{...}: {
  home.sessionVariables = {
    # Locale
    LANG = "en_US.UTF-8";

    # QT theme
    QT_QPA_PLATFORMTHEME = "gtk2";

    # Mozilla touchscreen support
    MOZ_USE_XINPUT2 = "1";
  };

  # Conditional tmux exit alias for SSH sessions
  programs.fish.interactiveShellInit = ''
    # Use tmux_exit when in tmux over SSH
    if set -q TMUX; and set -q SSH_CONNECTION
        alias exit tmux_exit
    end
  '';
}
