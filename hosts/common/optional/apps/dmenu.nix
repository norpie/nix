{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (dmenu.overrideAttrs (oldAttrs: {
      src = fetchgit {
        name = "dmenu";
        url = "https://github.com/norpie/dmenu";
        rev = "305f45cba29804dc3bba84780b4fc7e9ef03377d";
        sha256 = "sha256-rCHbOGjrbv15vb9hdEZ8W/2oJnw6yH60NKkHs0nvE2s=";
        };
    }))
  ];
}
