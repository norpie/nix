{lib, ...}: {
  services.plex = {
    enable = true;
    dataDir = "/mnt/data/plex";
    extraScanners = [
      (lib.fetchFromGitHub {
        owner = "ZeroQI";
        repo = "Absolute-Series-Scanner";
        rev = "773a39f502a1204b0b0255903cee4ed02c46fde0";
        sha256 = "4l+vpiDdC8L/EeJowUgYyB3JPNTZ1sauN8liFAcK+PY=";
      })
      (lib.fetchFromGitHub { # get from sops
        # owner = "";  # plex.plugins.personal.owner
        # repo = "";   # plex.plugins.personal.repo
        # rev = "";    # plex.plugins.personal.rev
        # sha256 = ""; # plex.plugins.personal.sha256
      })
    ];
  };
}
