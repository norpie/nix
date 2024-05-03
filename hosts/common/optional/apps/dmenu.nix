{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (dmenu.overrideAttrs (oldAttrs: {
      src = fetchgit {
        name = "dmenu";
        url = "https://github.com/norpie/dmenu";
        rev = "6417bade26a880fa777cb1c8f185af2feb607135";
        sha256 = "sha256-Zh3wjJ7eQV9h6gmQG9o7I8WOv9Kk7/xUIE2As5qJG/I=";
        };
    }))
  ];
}
