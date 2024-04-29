{...}: {
  imports = [
    ./nix.nix
    ./packages.nix
    ./shell.nix
    ./locale.nix
    ./network.nix
    ./boot.nix
  ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.getty.autologinUser = "norpie";

  system.stateVersion = "23.11"; # Did you read the comment?
}
