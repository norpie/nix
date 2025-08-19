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
    inputs.hardware.nixosModules.common-gpu-intel

    # Include the results of the hardware scan.
    ./hardware.nix
    inputs.hardware.nixosModules.lenovo-thinkpad-t490

    # Load the core.
    (configLib.relativeToRoot "hosts/common/core")

    # Load services.
    (configLib.relativeToRoot "hosts/common/optional/services/audio.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/printing.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/ssh.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/zerotierone.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/rustdesk.nix")
    (configLib.relativeToRoot "hosts/common/optional/services/bluetooth.nix")

    # (configLib.relativeToRoot "hosts/common/optional/virtualization.nix")

    # Load the optionals.
    (configLib.relativeToRoot "hosts/common/optional/desktop-apps.nix")
    (configLib.relativeToRoot "hosts/common/optional/desktops/hyprland-env.nix")
    # (configLib.relativeToRoot "hosts/common/optional/desktops/dwm-env.nix")
    (configLib.relativeToRoot "hosts/common/optional/latex.nix")

    # Load optional apps
    (configLib.relativeToRoot "hosts/common/optional/apps/gaming.nix")

    # Load user configurations.
    (configLib.relativeToRoot "hosts/common/users/norpie.nix")

    # Device specific configurations
    (configLib.relativeToRoot "hosts/venus/syncthing.nix")

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
      # When should the laptop start charging the battery?
      START_CHARGE_THRESH_BAT0 = 75;
      # When should the laptop stop charging the battery?
      STOP_CHARGE_THRESH_BAT0 = 80;
      # Selects the CPU driver to be used
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      # Selects a CPU frequency scaling governor
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
      # Set CPU energy/performance policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      # Define te min/max P-state for Intel CPUs as a percentage of the available performance
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 70;
      # Allow CPU to use the turbo boost feature
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      # Dynamic boost
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      USB_EXCLUDE_PHONE = 1;
    };
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  nixpkgs.config.packageOverrides = pkgs: {
    # intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapi-intel-hybrid
      # intel-vaapi-driver
      libvdpau-va-gl
      intel-ocl
    ];
  };

  services.throttled.enable = lib.mkForce false;

  networking.hostName = "venus";
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
