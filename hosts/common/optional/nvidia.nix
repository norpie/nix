{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
