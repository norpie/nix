{pkgs, ...}: {
  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "clearcpuid=514" # https://wiki.gentoo.org/wiki/Clearcpuid
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      # "iommu=pt"
      # "amd_iommu=on"
    ];
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
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
      timeout = 3;
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      themePackages = with pkgs; [
        plymouth-blahaj-theme
        # (adi1090x-plymouth-themes.override {
        #   selected_themes = ["rings"];
        # })
      ];
      theme = "blahaj";
    };
  };
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
