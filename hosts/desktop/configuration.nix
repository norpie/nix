{
  configLib,
  inputs,
  ...
}: {
  imports = [
    # Hardware modules
    inputs.hardware.nixosModules.common-cpu-amd

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/audio.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/printing.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/sync.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/bluetooth.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/plex.nix")

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/nvidia.nix")

    # Load apps.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    (configLib.relativeToRoot "hosts/common/optional/apps/steam.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")
  ];

  networking.hostName = "desktop";
}
