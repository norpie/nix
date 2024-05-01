{
  configLib,
  inputs,
  ...
}: {
  imports = [
    # Hardware modules
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd

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

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")
  ];

  services.tlp = {
      enable = true;
      settings = ''
        START_CHARGE_THRESH_BAT0=75
        STOP_CHARGE_THRESH_BAT0=80
      '';
};

  networking.hostName = "laptop";
  # networking.wireless.enable = true;
}
