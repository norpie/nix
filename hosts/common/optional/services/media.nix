{
  pkgs,
  lib,
  ...
}: {
  users = {
    groups.media = {
      name = "media";
    };
    users.mediamanager = {
      isSystemUser = true;
      home = "/mnt/data/data/prowlarr";
      group = "media";
      createHome = true;
      shell = "/run/current-system/sw/bin/nologin";
    };
  };
  services = {
    plex = {
      enable = true;
      user = "mediamanager";
      group = "media";
      dataDir = "/mnt/data/data/plex";
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
    #   dataDir = "/mnt/data/bazarr";
    #   enable = true;
    #   group = "media";
    #   port = 6767;
    # };
    sonarr = {
      dataDir = "/mnt/data/data/sonarr/config";
      enable = true;
      user = "mediamanager";
      group = "media";
      # port = 8989;
    };
    radarr = {
      dataDir = "/mnt/data/data/radarr/config";
      enable = true;
      user = "mediamanager";
      group = "media";
      # port = 7878;
    };
    # lidarr = {
    #   dataDir = "/mnt/data/lidarr";
    #   enable = true;
    #   group = "media";
    #   port = 8686;
    # };
    # readarr = {
    #   dataDir = "/mnt/data/readarr";
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
      user = "mediamanager";
      ExecStart = lib.mkForce "${lib.getExe pkgs.prowlarr} -nobrowser -data=/mnt/data/data/prowlarr/config";
    };
  };
}
