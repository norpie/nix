{pkgs, ...}: {
  boot = {
    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
    ];
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        # useOSProber = true;
        theme = pkgs.fetchFromGitHub {
          owner = "shvchk";
          repo = "fallout-grub-theme";
          rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
          sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
        };
      };
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
  };
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
