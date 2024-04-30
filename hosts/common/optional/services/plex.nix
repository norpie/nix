{pkgs, ...}: {
  services.plex = {
    enable = true;
    dataDir = "/mnt/data/plex";
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
}
