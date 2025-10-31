{...}: {
  programs.fish.functions = {
    tmux_exit = ''
      set pane_count (tmux list-panes | wc -l)
      set window_count (tmux list-windows | wc -l)

      if test $pane_count -gt 1
          tmux kill-pane
      else if test $window_count -gt 1
          tmux kill-window
      else
          tmux kill-session
      end
    '';
  };
}
