{
  description = "Norpie's NixOS configuration";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";

    # Overlays
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Custom modules
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    spicetify-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    configLib = import ./lib {inherit lib;};
    specialArgs = {inherit inputs configLib nixpkgs system spicetify-nix;};
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/desktop/configuration.nix")
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/laptop/configuration.nix")
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/vm/configuration.nix")
        ];
      };
    };

    packages.${system}.install = let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.writeShellApplication {
        name = "install";
        runtimeInputs = with pkgs; [
          git
          jq
          rsync
        ];
        text = ''sudo ${./install.sh} "$@"'';
      };

    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.install}/bin/install";
    };
  };
}
