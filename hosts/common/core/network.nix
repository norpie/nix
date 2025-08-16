{...}: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    hosts = {
      "10.147.17.59" = ["cepheus.vpn"];
      "10.147.17.202" = ["jupiter.vpn"];
      "10.147.17.250" = ["mars.vpn"];
      "10.147.17.196" = ["venus.vpn"];
      "0.0.0.0" = ["apresolve.spotify.com"];
      "::0" = ["apresolve.spotify.com"];
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Enable avahi (mDNS) network service discovery.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
