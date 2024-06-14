{pkgs, ...}: {
  virtualisation.docker = {
    package = pkgs.docker_26;
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
