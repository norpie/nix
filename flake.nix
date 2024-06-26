{
  description = "Norpie's NixOS configuration";

  inputs = {
    # Nixpkgs
    # nixstablepkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    # Overlays
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";

    # Custom modules
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    configLib = import ./lib {inherit lib;};
    specialArgs = {inherit inputs configLib nixpkgs system;};
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
      wsl = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/wsl/configuration.nix")
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
          ntfs3g
          btrfs-progs
        ];
        text = ''sudo ${./install.sh} "$@"'';
      };

    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.install}/bin/install";
    };
  };
}
