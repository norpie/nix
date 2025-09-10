{lib, ...}: let
  buildHosts = ["jupiter.local" "jupiter.vpn"];
in {
  nix = {
    settings = {
      trusted-users = ["nixremote"];
    };
    buildMachines = map (hostName: {
      inherit hostName;
      system = "x86_64-linux";
      protocol = "ssh-ng";
      sshUser = "nixremote";
      sshKey = "/root/.ssh/nixremote";
      maxJobs = 1;
      speedFactor = 1;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    }) buildHosts;
    distributedBuilds = true;
  };
}
