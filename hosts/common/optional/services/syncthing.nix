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
          "jupiter" = {
            id = "ANBXVIC-K2YZPTG-AB5JCBW-QOVMTGC-TVZXWIE-GA6MZWS-HH6B4YX-77ON5QV";
          };
          "venus" = {
            id = "MQ5SYLY-CGIMQBD-ALIEZ2Q-IIEUJ6Y-RYACWE7-M4ADN3R-UA7JOCS-2QBTLQX";
          };
          "mars" = {
              id = "HHYI6LI-BV5G5BT-CICJMZ2-5UQJDH3-QRP5KUZ-GQNYXEW-MHFY2MQ-WS6VFAT";
          };
          "luna" = {
            id = "PXKRPZD-5HNWIOA-KSZBSNB-76VPFN3-5JGGYWH-K7TDF2S-K4QDEPM-Z6DHIAL";
          };
          "wsl" = {
            id = "BLI7CJL-DNP5WJ7-YX3J567-HUDLNAG-CKWMNCD-XZGEPQC-CSV6C5K-BUZ3TAV";
          };
          "phone" = {
            id = "J4T3U4E-FNYLHMW-2VON4EX-JGPET43-D2EIPWW-QI3ZMOD-IMCE3E6-SJMU6A6";
          };
        };
      };
    };
  };
}
