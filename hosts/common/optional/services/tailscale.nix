{...}: {
  services.tailscale = {
    enable = true;

    useRoutingFeatures = "both";
    extraSetFlags = [
      "--advertise-exit-node"
    ];
  };
}
