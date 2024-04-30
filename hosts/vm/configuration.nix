{
    pkgs,
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
    (configLib.relativeToRoot "hosts/common/optional/services/sync.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rsync.nix")

    # Load the optionals.
    # (configLib.relativeToRoot "hosts/common/optional/desktops/plasma5.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")
  ];

  environment.systemPackages = with pkgs; [
    gparted
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  services.xserver.videoDrivers = [ "virtio" ];

  networking.hostName = "vm";
}
