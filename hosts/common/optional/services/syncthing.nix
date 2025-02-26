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
          password = "password";
          theme = "dark";
        };
        devices = {
          "desktop" = {
            id = "ANBXVIC-K2YZPTG-AB5JCBW-QOVMTGC-TVZXWIE-GA6MZWS-HH6B4YX-77ON5QV";
          };
          "venus" = {
            id = "MQ5SYLY-CGIMQBD-ALIEZ2Q-IIEUJ6Y-RYACWE7-M4ADN3R-UA7JOCS-2QBTLQX";
          };
          "tablet" = {
            id = "KR3YNCU-ZZCFCHC-EX3L2TJ-RO54QP2-KNW5ZAX-2KH6IE4-V2MDZO2-WQT7GQW";
          };
          "phone" = {
            id = "J4T3U4E-FNYLHMW-2VON4EX-JGPET43-D2EIPWW-QI3ZMOD-IMCE3E6-SJMU6A6";
          };
        };
      };
    };
  };
}
