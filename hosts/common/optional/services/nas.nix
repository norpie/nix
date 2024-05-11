{...}: {
  services = {
    samba-wsdd = {
      enable = true;
      interface = "virbr0";
      discovery = true;
    };
    samba = {
      enable = true;
      extraConfig = ''
        server string = nas
        hosts allow = 192.168.0. 127.0.0.1 localhost
      '';
      shares = {
        data = {
          comment = "Data drive";
          path = "/mnt/data";
          validUsers = ["norpie"];
          public = false;
          writable = true;
          printable = false;
          createMask = "0777";
        };
        media = {
          comment = "Media drive";
          path = "/mnt/media";
          validUsers = ["norpie"];
          public = false;
          writable = true;
          printable = false;
          createMask = "0765";
        };
        home = {
          comment = "Home dir";
          path = "/home/norpie";
          validUsers = ["norpie"];
          public = false;
          writable = true;
          printable = false;
          createMask = "0765";
        };
      };
    };
  };
}
