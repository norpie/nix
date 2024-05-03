{ ... }: {
  services.fstrim.enable = true;
  services.upower.enable = true;
  services.getty.autologinUser = "norpie";
}
