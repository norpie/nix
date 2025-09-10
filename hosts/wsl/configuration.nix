{
  pkgs,
  configLib,
  inputs,
  ...
}: {
  programs.nix-ld = {
    enable = true;
  };
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    (configLib.relativeToRoot "hosts/wsl/syncthing.nix")

    (configLib.relativeToRoot "hosts/common/core/dev.nix")
    (configLib.relativeToRoot "hosts/common/core/nix.nix")
    (configLib.relativeToRoot "hosts/common/core/packages.nix")
    (configLib.relativeToRoot "hosts/common/core/shell.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/zerotierone.nix")
    (configLib.relativeToRoot "hosts/common/optional/remote-building-client.nix")
  ];

  time = {
      timeZone = "Europe/Brussels";
      hardwareClockInLocalTime = true;
  };

  wsl.enable = true;
  wsl.defaultUser = "norpie";
  users.users.norpie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICYMKJo0UVB8Pl0ZfQAe9XLwhHSKfaCzP4ylZQqqFnGG"
  ];


  wsl.wslConf.network.hostname = "wsl";
  wsl.useWindowsDriver = true;
  wsl.docker-desktop.enable = true;

  environment.sessionVariables.LD_LIBRARY_PATH = [ "/run/opengl-driver/lib" ];

  environment.systemPackages = with pkgs; [
    xclip
  ];

  system.stateVersion = "24.05";
}
