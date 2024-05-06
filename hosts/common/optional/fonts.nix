{pkgs, ...}: {
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts.packages = with pkgs; [
    source-sans-pro
    nerdfonts
    joypixels
    lmodern
    lmmath
  ];
}
