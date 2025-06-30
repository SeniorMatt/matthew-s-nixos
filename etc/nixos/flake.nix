{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs-unstable.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
        };

        modules = [
	  inputs.catppuccin.nixosModules.catppuccin
          ./configuration.nix
          {
            nixpkgs.overlays = [
              (final: _: {
                # this allows you to access `pkgs.unstable` anywhere in your config
                unstable = import inputs.nixpkgs-unstable {
                  inherit (final.stdenv.hostPlatform) system;
                  inherit (final) config;
                };
              })
            ];
          }

          home-manager.nixosModules.default
          {
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.catppuccin.homeModules.catppuccin
            ];
          }
        ];
    };
  };
}
