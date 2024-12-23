{
  pkgs,
  configLib,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Hardware modules
    inputs.hardware.nixosModules.common-cpu-intel
    # inputs.hardware.nixosModules.common-gpu-intel

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.lenovo-thinkpad-t490

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/audio.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/printing.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rustdesk.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/bluetooth.nix")

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    # (configLib.relativeToRoot "hosts/common/optional/desktops/hyprland-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/latex.nix")

    # Load optional apps
    (configLib.relativeToRoot "hosts/common/optional/apps/gaming.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")

    # Device specific configurations
    (configLib.relativeToRoot "hosts/laptop/syncthing.nix")
    (configLib.relativeToRoot "hosts/laptop/zerotierone.nix")

    # Load miscellaneous configurations.
    (configLib.relativeToRoot "hosts/common/optional/docker.nix")
  ];

  nix = {
    settings = {
      trusted-users = ["nixremote"];
    };
    buildMachines = [
      {
        hostName = "192.168.129.56";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "nixremote";
        sshKey = "/root/.ssh/nixremote";
        maxJobs = 1;
        speedFactor = 1;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      }
    ];
    distributedBuilds = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      # USB_EXCLUDE_PHONE = 1;
    };
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      # intel-vaapi-driver
      libvdpau-va-gl
      intel-ocl
    ];
  };

  services.throttled.enable = lib.mkForce false;

  networking.hostName = "laptop";
  # networking.wireless.enable = true;

  services.fprintd = {
      enable = true;
  };

  services.fwupd.enable = true;

  # Forces a reset for specified bluetooth usb dongle.
  systemd.services.fix-generic-usb-bluetooth-dongle = {
    description = "Fixes for generic USB bluetooth dongle.";
    wantedBy = ["post-resume.target"];
    after = ["post-resume.target"];
    script = builtins.readFile ./scripts/hack.usb.reset;
    scriptArgs = "8087:0aaa"; # Vendor ID and Product ID here
    serviceConfig.Type = "oneshot";
  };

  programs.kdeconnect.enable = true;
}
