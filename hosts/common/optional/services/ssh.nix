{...}: {
  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          ForceCommand = "tmux new-session -A -s ssh";
      };
  };
  programs.ssh.startAgent = true;
}
