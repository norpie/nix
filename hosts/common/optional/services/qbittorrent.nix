{lib, ...}: {
  services.qbittorrent = {
    enable = true;
    user = "mediamanager";
    group = "media";
    profileDir = "/mnt/data/data/qbittorrent";
    webuiPort = 9999;
    torrentingPort = 6881;
    extraArgs = [
      "--confirm-legal-notice"
    ];
  };

  systemd.services.qbittorrent.serviceConfig.ProtectHome = lib.mkForce "no";
}