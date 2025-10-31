{
  pkgs,
  lib,
  ...
}: let
  # Auto-import all .nix files from a directory
  importDir = dir:
    let
      files = builtins.readDir dir;
      nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) files;
    in
    map (name: dir + "/${name}") (builtins.attrNames nixFiles);
in {
  imports = [
    ./aliases.nix
  ] ++ (importDir ./environment) ++ (importDir ./functions);

  programs.fish = {
    enable = true;

    # SSH agent and WSL tmux auto-start (login shell init)
    loginShellInit = ''
      # Use cached SSH agent from Hyprland init if available
      if test -f ~/.cache/ssh_auth_sock; and test -f ~/.cache/ssh_agent_pid
          set -gx SSH_AUTH_SOCK (cat ~/.cache/ssh_auth_sock)
          set -gx SSH_AGENT_PID (cat ~/.cache/ssh_agent_pid)

          # Verify the agent is still running
          if not kill -0 $SSH_AGENT_PID 2>/dev/null
              echo "Cached SSH agent is dead, starting new one"
              eval (ssh-agent -c)
              ssh-add-defaults
          end
      else if not set -q SSH_AGENT_PID
          echo "No cached SSH agent, starting new one"
          eval (ssh-agent -c)
          ssh-add-defaults
      end

      # Auto-start tmux only in WSL
      if test -f /proc/version; and grep -qi microsoft /proc/version
          if command -v tmux > /dev/null; and test -n "$PS1"; and not string match -q -r "screen|tmux" "$TERM"; and test -z "$TMUX"
              set -gx TERM xterm-256color
              exec tmux new-session -A -s default
          end
      end
    '';

    # Interactive shell configuration
    interactiveShellInit = ''
      # Vim mode keybindings
      fish_vi_key_bindings

      # Custom keybindings
      bind -M insert \ce accept-autosuggestion  # Ctrl+E to accept suggestion
      bind -M insert \cw forward-word           # Ctrl+W to accept one word
      bind -M insert \cz 'echo "Ctrl+Z disabled"'  # Disable Ctrl+Z

      # Custom vi mode navigation (jkl; instead of hjkl)
      # Normal mode
      bind -M default j backward-char    # j = left
      bind -M default k down-line        # k = down
      bind -M default l up-line          # l = up
      bind -M default \; forward-char    # ; = right

      # Visual mode
      bind -M visual j backward-char     # j = left
      bind -M visual k down-line         # k = down
      bind -M visual l up-line           # l = up
      bind -M visual \; forward-char     # ; = right

      # Catppuccin Mocha colors for Fish
      # Based on https://github.com/catppuccin/fish
      set -g fish_color_normal cdd6f4
      set -g fish_color_command a6e3a1
      set -g fish_color_param f2cdcd
      set -g fish_color_keyword f38ba8
      set -g fish_color_quote f9e2af
      set -g fish_color_redirection f5c2e7
      set -g fish_color_end fab387
      set -g fish_color_error f38ba8
      set -g fish_color_gray 6c7086
      set -g fish_color_selection --background=313244
      set -g fish_color_search_match --background=313244
      set -g fish_color_operator f5c2e7
      set -g fish_color_escape eba0ac
      set -g fish_color_autosuggestion 6c7086
      set -g fish_color_cancel f38ba8
      set -g fish_color_cwd f9e2af
      set -g fish_color_user 94e2d5
      set -g fish_color_host a6e3a1
      set -g fish_color_host_remote f9e2af
      set -g fish_color_status f38ba8
      set -g fish_pager_color_progress 6c7086
      set -g fish_pager_color_prefix f5c2e7
      set -g fish_pager_color_completion cdd6f4
      set -g fish_pager_color_description 6c7086
    '';

    # Shell integrations and initialization
    shellInit = ''
      # Disable greeting message
      set -g fish_greeting

      # History settings
      set -g fish_history_file $HOME/.cache/fish/history

      # FZF integration
      if command -v fzf > /dev/null
          fzf --fish | source
      end

      # Zoxide integration
      if command -v zoxide > /dev/null
          zoxide init fish | source
      end
    '';
  };
}
