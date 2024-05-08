{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
