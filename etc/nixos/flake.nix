{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let 
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix

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
