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

  wsl.docker-desktop.enable = true;

  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    zerotierone
  ];

  services = {
    syncthing = {
      guiAddress = "127.0.0.1:8384";
      enable = true;
      user = "norpie";
      dataDir = "/home/norpie"; # Default folder for new synced folders
      configDir = "/home/norpie/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        gui = {
          address = "127.0.0.1:8384";
          password = "password";
          theme = "dark";
        };
        devices = {
          "jupiter" = {
            id = "ANBXVIC-K2YZPTG-AB5JCBW-QOVMTGC-TVZXWIE-GA6MZWS-HH6B4YX-77ON5QV";
          };
        };
        folders = {
          "work" = {
            id = "za4mr-vatzw";
            path = "/home/norpie/repos";
            devices = [ "jupiter" ];
          };
        };
      };
    };
  };
}
