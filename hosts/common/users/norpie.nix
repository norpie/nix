{...}: {
  users = {
    users = {
      norpie = {
        isNormalUser = true;
        description = "Konsta Kuosmanen";
        extraGroups = [
          "cups"
          "networkmanager"
          "wheel"
          "media"
          "input"
          "libvirt"
          "docker"
          "audio"
          "video"
          "storage"
          "optical"
          "scanner"
          "power"
          "rfkill"
          "users"
          "lp"
          "kvm"
          "adbusers"
        ];
        hashedPassword = "$6$yrmuKldtP/mKYReB$9w8pTeEmK/oY2xnY2mG5Wwj6N72qoeoYp.zIHpPS7/inQrR70LU0dNvjUFc0hTFvS9BcwUV9XY2.girsF8JyN.";
        openssh = {
          authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICYMKJo0UVB8Pl0ZfQAe9XLwhHSKfaCzP4ylZQqqFnGG"
          ];
        };
      };

      root = {
        isNormalUser = false;
        hashedPassword = "$6$yrmuKldtP/mKYReB$9w8pTeEmK/oY2xnY2mG5Wwj6N72qoeoYp.zIHpPS7/inQrR70LU0dNvjUFc0hTFvS9BcwUV9XY2.girsF8JyN.";
      };
    };
    groups = {
      docker = {};
      libvirt = {};
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
