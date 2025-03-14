{
  pkgs,
  configLib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    (configLib.relativeToRoot "hosts/common/core/dev.nix")
    (configLib.relativeToRoot "hosts/common/core/nix.nix")
    (configLib.relativeToRoot "hosts/common/core/packages.nix")
    (configLib.relativeToRoot "hosts/common/core/shell.nix")
  ];

  wsl.enable = true;
  wsl.defaultUser = "norpie";

  wsl.wslConf.network.hostname = "wsl";

  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    zerotierone
  ];
}
