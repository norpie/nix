{...}: {
  programs.fish.functions = {
    config = ''
      # Special case for CS config
      if test (count $argv) -eq 1; and test "$argv[1]" = "cs"
          $EDITOR "$HOME/.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg/autoexec.cfg"
          return
      end

      set file (find $XDG_CONFIG_HOME -maxdepth 5 | fzf --preview 'if test -d {}; ls {}; else; pygmentize -g {}; end')
      if test -d "$file"
          cd $file
      else if test -f "$file"
          $EDITOR $file
      end
    '';
  };
}
