{...}: {
  programs.fish.functions = {
    yazi = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      command yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          cd -- "$cwd"
      end
      rm -f -- "$tmp"
    '';
  };
}
