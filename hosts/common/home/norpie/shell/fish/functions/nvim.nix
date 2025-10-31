{...}: {
  programs.fish.functions = {
    nvim = ''
      if test (count $argv) -eq 0
          command nvim
      else
          command nvim -p $argv
      end
    '';
  };
}
