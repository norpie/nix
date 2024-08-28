{
  pkgs,
  inputs,
  ...
}: {
  services.fstrim.enable = true;
  services.upower.enable = true;
  services.getty.autologinUser = "norpie";
  services.smartd.enable = true;
  environment.systemPackages = with pkgs; [
    smartmontools
  ];
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
}
