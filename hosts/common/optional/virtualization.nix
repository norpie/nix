{pkgs, ...}: {
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm = {
        enable = true;
      };
      ovmf = {
        enable = true;
        packages = [
          (
            pkgs.unstable.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }
          )
          .fd
        ];
      };
    };
  };
  programs.virt-manager = {
    enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      quickemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };
}
