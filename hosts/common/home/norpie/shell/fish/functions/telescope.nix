{...}: {
  programs.fish.functions = {
    telescope = ''
      set file (find | fzf --preview 'if test -d {}; ls {}; else; pygmentize -g {}; end')
      if test -d "$file"
          cd $file
      else if test -f "$file"
          $EDITOR $file
      end
    '';
  };
}
