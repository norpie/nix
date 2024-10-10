{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cura
  ];
}
