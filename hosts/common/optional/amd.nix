{pkgs, lib, ...}: {
  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver.videoDrivers = ["amdgpu"];

  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        clr
        rocblas
        rocm-comgr
        rocm-cmake
        rocm-device-libs
        rocm-runtime
        hipblas
        hipblas-common
        hipcc
        rocminfo
        hiprand
        rocrand
        rocprim
        rocthrust
        hipcub
        rocfft
        miopen

        llvm.llvm
        llvm.clang
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      libvdpau-va-gl
      rocmPackages.clr.icd
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {"LIBVA_DRIVER_NAME" = "radeonsi";};

  nixpkgs.config = {
    rocmSupport = true;
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    lact
    clinfo
    libva-utils
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    vulkan-tools
    gpu-viewer
  ];

  hardware.amdgpu.overdrive.enable = true;

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
}
