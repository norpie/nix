{...}: {
  programs.fish.functions = {
    script = ''
      if test (count $argv) -eq 0
          set file (find $SCRIPT_DIR | fzf)
          if test -d "$file"
              cd $file
          else if test -f "$file"
              $EDITOR $file
          end
      else
          set SCRIPT_PATH "/home/norpie/.local/bin/$argv[1]"
          if not test -f $SCRIPT_PATH
              echo '#!/usr/bin/env bash' > $SCRIPT_PATH
              chmod +x $SCRIPT_PATH
          end
          $EDITOR $SCRIPT_PATH
      end
    '';
  };
}
