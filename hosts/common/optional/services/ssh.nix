{...}: {
  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          ForceCommand = "tmux new-session -A -s ssh";
      };
      extraConfig = ''
        Match User nixremote
          ForceCommand none
      '';
  };
  programs.ssh.startAgent = true;
}
