{pkgs, ...}: {
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts.packages = with pkgs; [
    nerdfonts
    joypixels
    jetbrains-mono
  ];
}
