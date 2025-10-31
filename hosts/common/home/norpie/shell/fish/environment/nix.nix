{...}: {
  home.sessionVariables = {
    # Nix configuration
    NH_FLAKE = "$HOME/repos/nix";
    FLAKE = "$HOME/repos/nix";
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_INSECURE = "1";
    NIXPKGS_ALLOW_BROKEN = "0";
  };
}
