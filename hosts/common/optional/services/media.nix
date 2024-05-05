{
  pkgs,
  lib,
  ...
}: {
  services = {
    plex = {
      enable = true;
      user = "plex";
      dataDir = "/mnt/media/plex";
      extraScanners = [
        (pkgs.fetchFromGitHub {
          owner = "ZeroQI";
          repo = "Absolute-Series-Scanner";
          rev = "c5e3db9bdbcf373667afd5177834907a0d136313";
          sha256 = "sha256-/+JqTPRwN0/g1+zZg/zL80zFASZ/YWqZObWVJlIcztA=";
        })
        #(pkgs.fetchFromGitHub { # get from sops
        # owner = "";  # plex.plugins.personal.owner
        # repo = "";   # plex.plugins.personal.repo
        # rev = "";    # plex.plugins.personal.rev
        # sha256 = ""; # plex.plugins.personal.sha256
        #})
      ];
      extraPlugins = [
        (builtins.path {
          name = "Audnexus.bundle";
          path = pkgs.fetchFromGitHub {
            owner = "djdembeck";
            repo = "Audnexus.bundle";
            rev = "5bfd290e2f68020531dfbedd7f83400b322318e5";
            sha256 = "sha256-HgbPZdKZq3uT44n+4owjPajBbkEENexyPwkFuriiqU4=";
          };
        })
      ];
    };
    # bazarr = {
    #   dataDir = "/mnt/media/bazarr";
    #   enable = true;
    #   group = "media";
    #   port = 6767;
    # };
    sonarr = {
      dataDir = "/mnt/media/sonarr";
      enable = true;
      user = "norpie";
      # port = 8989;
    };
    radarr = {
      dataDir = "/mnt/media/radarr";
      enable = true;
      user = "norpie";
      # port = 7878;
    };
    # lidarr = {
    #   dataDir = "/mnt/media/lidarr";
    #   enable = true;
    #   group = "media";
    #   port = 8686;
    # };
    # readarr = {
    #   dataDir = "/mnt/media/readarr";
    #   enable = true;
    #   group = "media";
    #   port = 8787;
    # };
    prowlarr = {
      enable = true;
    };
  };
  systemd.services.prowlarr = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "norpie";
      ExecStart = lib.mkForce "${lib.getExe pkgs.prowlarr} -nobrowser -data=/mnt/media/prowlarr";
    };
  };
}
