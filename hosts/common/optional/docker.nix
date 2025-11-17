{
  pkgs,
  lib,
  config,
  ...
}: {
  # hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    # package = pkgs.docker_26;
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        # Enable buildx by default
        features = {
          buildkit = true;
        };
      };
      extraPackages = with pkgs; [
        docker-compose
        docker-buildx
      ];
    };
  };

  # Set up Docker CLI plugins for rootless Docker
  home-manager.users.norpie = {
    home.file.".docker/cli-plugins/docker-buildx" = {
      source = "${pkgs.docker-buildx}/bin/docker-buildx";
    };
    home.file.".docker/cli-plugins/docker-compose" = {
      source = "${pkgs.docker-compose}/bin/docker-compose";
    };
  };
}
