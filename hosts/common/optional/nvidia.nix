{config, pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;

  hardware.opengl = {
    enable = true;
    driSupport = true; # This is already enabled by default
    driSupport32Bit = true; # For 32 bit applications
  };

  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nixpkgs.config = {
    cudaSupport = true;
  };
  
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];
}
