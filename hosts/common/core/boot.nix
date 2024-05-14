{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
