{
  description = "Norpie's NixOS configuration";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Nixpkgs unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nixpkgs master
    # nixpkgs.url = "github:nixos/nixpkgs/master";

    # Nixpkgs local: ~/repos/nixpkgs
    # nixpkgs.url = "/home/norpie/repos/nixpkgs";

    # Nixpkgs pr
    # nixpkgs.url = "github:mschwaig/nixpkgs/comically-bad-rocm-workaround";

    hardware.url = "github:NixOS/nixos-hardware";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    # Norpie's suckless builds
    dwm.url = "github:norpie/dwm";
    st.url = "github:norpie/st";
    dmenu.url = "github:norpie/dmenu";

    # Lix
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-1.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Overlays
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";

    # Custom modules
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    # lix-module,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    configLib = import ./lib {inherit lib;};
    specialArgs = {inherit inputs configLib nixpkgs system;};
  in {
    nixosConfigurations = {
      jupiter = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/jupiter/configuration.nix")
          # lix-module.nixosModules.default
        ];
      };
      venus = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/venus/configuration.nix")
          # lix-module.nixosModules.default
        ];
      };
      mars = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/mars/configuration.nix")
          # lix-module.nixosModules.default
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          (configLib.relativeToRoot "hosts/wsl/configuration.nix")
          # lix-module.nixosModules.default
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          (configLib.relativeToRoot "hosts/vm/configuration.nix")
          # lix-module.nixosModules.default
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
