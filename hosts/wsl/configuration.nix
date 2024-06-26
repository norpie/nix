{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    defaultUser = "norpie";

    enable = true;
    wslConf.automount.root = "/mnt";
  };

  # WSL is closer to a container than anything else
  boot.isContainer = true;

  networking.hostName = "wsl";

  environment.etc.hosts.enable = false;
  environment.etc."resolv.conf".enable = false;

  networking.dhcpcd.enable = false;

  users.users.root = {
    # Otherwise WSL fails to login as root with "initgroups failed 5"
    extraGroups = ["root"];
  };

  security.sudo.wheelNeedsPassword = false;

  # Disable systemd units that don't make sense on WSL
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

  systemd.services.firewall.enable = false;
  systemd.services.systemd-resolved.enable = false;
  systemd.services.systemd-udevd.enable = false;

  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;

  environment.systemPackages = with pkgs; [
    # Required for WSL
    wslu
  ];
}
