{...}: {
  programs.fish.functions = {
    cd = ''
      # Stop recording history if we cd into /mnt or move around in /mnt
      if string match -q "/mnt*" -- $argv[1]; or string match -q "/mnt*" -- $PWD
          if test "$HISTFILE" != "/dev/null"
              set -gx HISTFILE /dev/null
              echo "History disabled"
              # Remove last history entry
              if test -f $HOME/.cache/fish/history
                  sed -i '$ d' $HOME/.cache/fish/history
              end
          end
      else
          if test "$HISTFILE" = "/dev/null"
              set -gx HISTFILE $HOME/.cache/fish/history
              echo "History enabled"
          end
      end

      # If no arguments, and in git dir and not in git root, cd to git root
      if test (count $argv) -eq 0
          set GIT_ROOT (project subroot 2>/dev/null)
          if test -n "$GIT_ROOT"; and test "$GIT_ROOT" = "$PWD"
              builtin cd
          else if test -n "$GIT_ROOT"
              builtin cd $GIT_ROOT
          else
              builtin cd
          end
          return
      end

      # Use zoxide for navigation
      z $argv
    '';

    back = ''
      cd -
    '';
  };
}
