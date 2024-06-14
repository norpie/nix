{pkgs, ...}: {
  services.fstrim.enable = true;
  services.upower.enable = true;
  services.getty.autologinUser = "norpie";
  services.smartd.enable = true;
  environment.systemPackages = with pkgs; [
    smartmontools
  ];
}
