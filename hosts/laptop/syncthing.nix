{...}: {
  services = {
    syncthing = {
      guiAddress = "127.0.0.1:8384";
      enable = true;
      user = "norpie";
      dataDir = "/home/norpie"; # Default folder for new synced folders
      configDir = "/home/norpie/.config/syncthing"; # Folder for Syncthing's settings and keys
      extraFlags = [
        "--no-browser"
      ];
      settings = {
        gui = {
          address = "127.0.0.1:8384";
          password = "password";
          theme = "dark";
        };
        devices = {
          "desktop" = {
            id = "ANBXVIC-K2YZPTG-AB5JCBW-QOVMTGC-TVZXWIE-GA6MZWS-HH6B4YX-77ON5QV";
          };
          "tablet" = {
            id = "KR3YNCU-ZZCFCHC-EX3L2TJ-RO54QP2-KNW5ZAX-2KH6IE4-V2MDZO2-WQT7GQW";
          };
          "phone" = {
            id = "XZTNEYP-W5BLWMV-GHVMQG5-WXKBSPZ-D5BGYKK-AMP5HYS-GTTQ7Y7-QWAQCQV";
          };
        };
        folders = {
          "hs" = {
            id = "za4mt-vatzw";
            path = "/home/norpie/hs";
            devices = ["desktop"];
          };
          "notes" = {
            id = "dcee5-k9bqk";
            path = "/home/norpie/notes";
            devices = ["desktop"];
          };
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["desktop"];
          };
        };
      };
    };
  };
}
