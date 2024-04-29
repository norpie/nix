{...}: {
  imports = [
    ./nix.nix
    ./packages.nix
    ./shell.nix
    ./locale.nix
    ./network.nix
    ./boot.nix
  ];
  system.stateVersion = "23.11"; # Did you read the comment?
}
