{pkgs, ...}: {
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # package = pkgs.qemu_full;
        runAsRoot = true;
        swtpm = {
          enable = true;
        };
      };
    };
  };
  programs.virt-manager = {
    enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      virtiofsd
      quickemu
      # quickgui
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
      remmina
    ];
  };
}
