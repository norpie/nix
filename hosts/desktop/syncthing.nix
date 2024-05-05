{...}: {
  services = {
    syncthing = {
      guiAddress = "127.0.0.1:8384";
      enable = true;
      user = "norpie";
      dataDir = "/home/norpie"; # Default folder for new synced folders
      configDir = "/home/norpie/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        gui = {
          address = "127.0.0.1:8384";
          theme = "dark";
          password = "password";
        };
        overrideDevices = true;
        overrideFolders = true;
        devices = {
          "laptop" = {
            id = "6TZOIHZ-RX6E4DA-ZM2FBLP-OHO66HE-DYCBI52-GDTTT3A-WD65IKD-RSTJHQJ";
            autoAcceptFolders = true;
          };
          "tablet" = {
            id = "KR3YNCU-ZZCFCHC-EX3L2TJ-RO54QP2-KNW5ZAX-2KH6IE4-V2MDZO2-WQT7GQW";
            # autoAcceptFolders = true;
          };
          "phone" = {
            id = "XZTNEYP-W5BLWMV-GHVMQG5-WXKBSPZ-D5BGYKK-AMP5HYS-GTTQ7Y7-QWAQCQV";
            # autoAcceptFolders = true;
          };
        };
        folders = {
          "hs" = {
            id = "za4mt-vatzw";
            path = "/home/norpie/hs";
            devices = ["laptop" "tablet" "phone"];
          };
          "notes" = {
            id = "dcee5-k9bqk";
            path = "/home/norpie/notes";
            devices = ["laptop" "tablet" "phone"];
          };
          "pix" = {
            id = "aamey-zie5x";
            path = "/mnt/data/pix";
            devices = ["phone"];
          };
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["laptop"];
          };
        };
      };
    };
  };
}
