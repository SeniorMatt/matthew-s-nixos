{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nvf.url = "github:notashelf/nvf";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix

        {
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            ./modules/home-manager/fish.nix
            ./modules/home-manager/git.nix
            ./modules/home-manager/nvf.nix
            inputs.catppuccin.homeModules.catppuccin
          ];
        }
      ];
    };
  };
}
