{pkgs, ...}: {
  # hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    # package = pkgs.docker_26;
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    extraPackages = with pkgs; [
      docker-compose
      docker-buildx
    ];
  };
}
