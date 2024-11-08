{pkgs, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver.videoDrivers = ["amdgpu"];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  environment.sessionVariables = {"LIBVA_DRIVER_NAME" = "radeonsi";};

  nixpkgs.config = {
    rocmSupport = true;
  };

  environment.systemPackages = with pkgs; [
    lact
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
  ];
}
