{pkgs, ...}: {
  boot = {
    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
    ];
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
