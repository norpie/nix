{...}: {
  services = {
    # samba-wsdd = {
    #   enable = true;
    #   interface = "virbr0";
    #   discovery = true;
    # };
    samba = {
      enable = true;
      settings = {
        global = {
          workgroup = "WORKGROUP";
          "server role" = "standalone server";
          "allow insecure wide links" = true;
        };
        data = {
          comment = "Data drive";
          path = "/mnt/data";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0777";
        };
        media = {
          comment = "Media drive";
          path = "/mnt/media";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0777";
        };
        repos = {
          comment = "Repos";
          path = "/home/norpie/repos";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0777";
          "follow symlinks" = true;
          "wide links" = true;
        };
        home = {
          comment = "Home dir";
          path = "/home/norpie";
          "valid users" = "norpie";
          public = false;
          writable = true;
          printable = false;
          "create mask" = "0777";
        };
      };
    };
  };
}
