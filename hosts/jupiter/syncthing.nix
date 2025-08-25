{configLib, ...}: {
  imports = [
    (configLib.relativeToRoot "hosts/common/optional/services/syncthing.nix")
  ];
  services = {
    syncthing = {
      settings = {
        folders = {
          "hs" = {
            id = "za4mt-vatzw";
            path = "/home/norpie/hs";
            devices = ["venus" "mars" "luna" "phone"];
          };
          "notes" = {
            id = "dcee5-k9bqk";
            path = "/home/norpie/notes";
            devices = ["venus" "mars" "luna" "phone" "wsl"];
          };
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["venus" "mars"];
          };
          "persist" = {
            id = "l3svj-e4nev";
            path = "/home/norpie/persist";
            devices = ["venus" "mars" "luna"];
          };
          "wallpapers" = {
            id = "pc9rq-s2mfn";
            path = "/home/norpie/.config/wallpapers";
            devices = ["venus" "mars" "luna"];
          };
          "pix" = {
            id = "aamey-zie5x";
            path = "/mnt/data/pix";
            devices = ["phone"];
            ignoreDelete = true;
          };
          "work" = {
            id = "za4mr-vatzw";
            path = "/home/norpie/work";
            devices = ["wsl" "mars"];
          };
        };
      };
    };
  };
}
