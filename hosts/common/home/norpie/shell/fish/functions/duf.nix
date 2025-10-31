{...}: {
  programs.fish.functions = {
    duf = ''
      if test (count $argv) -eq 0
          command duf -only local,fuse
      else
          command duf $argv
      end
    '';
  };
}
