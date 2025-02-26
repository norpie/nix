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
            devices = ["venus" "tablet" "phone"];
          };
          "notes" = {
            id = "dcee5-k9bqk";
            path = "/home/norpie/notes";
            devices = ["venus" "tablet" "phone"];
          };
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["venus"];
          };
          "persist" = {
            id = "l3svj-e4nev";
            path = "/home/norpie/persist";
            devices = ["venus"];
          };
          "wallpapers" = {
            id = "pc9rq-s2mfn";
            path = "/home/norpie/.config/wallpapers";
            devices = ["venus"];
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
