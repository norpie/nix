{
  configLib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Hardware modules
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    (configLib.relativeToRoot "hosts/common/optional/amd.nix")

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/audio.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/printing.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/bluetooth.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rustdesk.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/media.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/nas.nix")

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/docker.nix")
    (configLib.relativeToRoot "hosts/common/optional/learning.nix")
    (configLib.relativeToRoot "hosts/common/optional/latex.nix")

    # Load apps.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/gaming.nix")

    # Load miscellaneous configurations.
    (configLib.relativeToRoot "hosts/common/optional/virtualization.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")

    # Device specific configuration.
    (configLib.relativeToRoot "hosts/desktop/syncthing.nix")
    (configLib.relativeToRoot "hosts/desktop/zerotierone.nix")
  ];

  networking.hostName = "desktop";

  environment.systemPackages = with pkgs; [
    # nixpkgs-wonderdraft.wonderdraft
    wonderdraft
    kdenlive
    obs-studio
    lsof
  ];
}
