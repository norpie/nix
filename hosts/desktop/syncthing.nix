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
          "laptop" = {
            id = "NEJ6OFK-EDIY7BQ-TSLPY7G-2W7IUZO-JCODV6X-EYRXU3Y-HIOFBNQ-X5XQRQI";
          };
          "tablet" = {
            id = "KR3YNCU-ZZCFCHC-EX3L2TJ-RO54QP2-KNW5ZAX-2KH6IE4-V2MDZO2-WQT7GQW";
          };
          "phone" = {
            id = "J4T3U4E-FNYLHMW-2VON4EX-JGPET43-D2EIPWW-QI3ZMOD-IMCE3E6-SJMU6A6";
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
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["laptop"];
          };
          "persist" = {
            id = "l3svj-e4nev";
            path = "/home/norpie/persist";
            devices = ["laptop" "phone"];
          };
          "pix" = {
            id = "aamey-zie5x";
            path = "/mnt/data/pix";
            devices = ["phone"];
            ignoreDelete = true;
          };
        };
      };
    };
  };
}
