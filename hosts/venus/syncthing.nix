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
            devices = ["jupiter" "mars" "luna" "phone"];
          };
          "notes" = {
            id = "dcee5-k9bqk";
            path = "/home/norpie/notes";
            devices = ["jupiter" "mars" "luna" "phone"];
          };
          "repos" = {
            id = "sfnmm-fqmsg";
            path = "/home/norpie/repos";
            devices = ["jupiter" "mars"];
          };
          "persist" = {
            id = "l3svj-e4nev";
            path = "/home/norpie/persist";
            devices = ["jupiter" "mars" "luna"];
          };
          "wallpapers" = {
            id = "pc9rq-s2mfn";
            path = "/home/norpie/.config/wallpapers";
            devices = ["jupiter" "mars"];
          };
        };
      };
    };
  };
}
