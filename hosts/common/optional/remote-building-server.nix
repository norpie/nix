{pkgs, ...}: {
  # create user for remote builds (on remote machine)
  users.users."nixremote" = {
    shell = pkgs.bash;
    home = "/home/nixremote";
    createHome = true;
    description = "Remote Nix Builder";
    isSystemUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJyQ2UcvWgSj07A5ezunVR2C7be24PprkD4vV+kU1Tou nixremote@jupiter"
    ];
    group = "nixremote";
  };

  users.groups."nixremote" = {};
}