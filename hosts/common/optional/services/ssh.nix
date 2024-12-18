{...}: {
  # Enable the OpenSSH daemon.
  services.openssh = {
      enable = true;
      settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
      };
  };
  programs.ssh.startAgent = true;
}
