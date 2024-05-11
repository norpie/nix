{...}: {
  services = {
    # samba-wsdd = {
    #   enable = true;
    #   interface = "virbr0";
    #   discovery = true;
    # };
    samba = {
      enable = true;
      extraConfig = ''
        workgroup = WORKGROUP
        server role = standalone server
      '';
      shares = {
        data = {
          comment = "Data drive";
          path = "/mnt/data";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0765";
        };
        media = {
          comment = "Media drive";
          path = "/mnt/media";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0765";
        };
        home = {
          comment = "Home dir";
          path = "/home/norpie";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0765";
        };
      };
    };
  };
}
