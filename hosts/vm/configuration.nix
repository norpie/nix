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
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rsync.nix")

    # Load the optionals.
    # (configLib.relativeToRoot "hosts/common/optional/desktops/plasma5.nix")
    # (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/hyprland-env.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")
    
    # Load remote building client
    (configLib.relativeToRoot "hosts/common/optional/remote-building-client.nix")
  ];

  environment.systemPackages = with pkgs; [
    gparted
    firefox-bin
  ];

  services.qemuGuest.enable = true;
  services.spice-autorandr.enable = true;
  services.spice-vdagentd.enable = true;

  # For Wayland/Hyprland in VM
  boot.kernelParams = [ "video=Virtual-1:1920x1080@60" ];

  networking.hostName = "vm";


  # PAM configuration for hyprlock
  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';
  };
}
