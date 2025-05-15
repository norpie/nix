{
  pkgs,
  configLib,
  inputs,
  ...
}: let
  wsl-lib = pkgs.runCommand "wsl-lib" {} ''
    mkdir -p "$out/lib"
    # # We can't just symlink the lib directory, because it will break merging with other drivers that provide the same directory
    ln -s /usr/lib/wsl/lib/libcudadebugger.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so.1.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libd3d12core.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libd3d12.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libdxcore.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvcuvid.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvcuvid.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvdxdlkernels.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-encode.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-encode.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-ml.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-opticalflow.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-opticalflow.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvoptix.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvwgf2umx.so "$out/lib"
    ln -s /usr/lib/wsl/lib/nvidia-smi "$out/lib"
  '';
in {
  programs.nix-ld = {
    enable = true;
    libraries = [wsl-lib];
  };
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    (configLib.relativeToRoot "hosts/common/core/dev.nix")
    (configLib.relativeToRoot "hosts/common/core/nix.nix")
    (configLib.relativeToRoot "hosts/common/core/packages.nix")
    (configLib.relativeToRoot "hosts/common/core/shell.nix")
  ];

  wsl.enable = true;
  wsl.defaultUser = "norpie";

  wsl.wslConf.network.hostname = "wsl";
  wsl.useWindowsDriver = true;
  # hardware.opengl.setLdLibraryPath = true;
  wsl.docker-desktop.enable = true;

  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #     daemon.settings = {
  #       features.cdi = true;
  #       cdi-spec-dirs = ["/home/norpie/.cdi"];
  #     };
  #   };
  #   daemon.settings = {
  #     features.cdi = true;
  #     cdi-spec-dirs = ["/etc/cdi"];
  #   };
  # };
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      # enabled = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      open = false;
    };
    nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = false;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];

  # services.open-webui = {
  #     enable = true;
  # };

  # services.ollama = {
  #     enable = true;
  #     acceleration = "cuda";
  # };

  system.stateVersion = "24.05";

  environment.sessionVariables.LD_LIBRARY_PATH = [ "/run/opengl-driver/lib" ];

  environment.systemPackages = with pkgs; [
    zerotierone
    nvidia-container-toolkit
    xclip
  ];

  services = {
    syncthing = {
      guiAddress = "0.0.0.0:8384";
      enable = true;
      user = "norpie";
      dataDir = "/home/norpie"; # Default folder for new synced folders
      configDir = "/home/norpie/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        gui = {
          address = "0.0.0.0:8384";
          password = "password";
          theme = "dark";
        };
        devices = {
          "jupiter" = {
            id = "ANBXVIC-K2YZPTG-AB5JCBW-QOVMTGC-TVZXWIE-GA6MZWS-HH6B4YX-77ON5QV";
          };
        };
        folders = {
          "work" = {
            id = "za4mr-vatzw";
            path = "/home/norpie/repos";
            devices = ["jupiter"];
          };
        };
      };
    };
  };
}
