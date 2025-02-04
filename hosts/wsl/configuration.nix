{
  pkgs,
  configLib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    (configLib.relativeToRoot "hosts/common/core/dev")
    (configLib.relativeToRoot "hosts/common/core/nix")
    (configLib.relativeToRoot "hosts/common/core/packages")
    (configLib.relativeToRoot "hosts/common/core/shell")
  ];

  wsl.enable = true;
  wsl.defaultUser = "norpie";

  wsl.wslConf.network.hostname = "wsl";

  system.stateVersion = "24.05";
}
