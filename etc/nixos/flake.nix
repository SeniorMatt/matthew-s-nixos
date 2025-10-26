{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";

    plasma-manager.url = "github:AlexNabokikh/plasma-manager";
    breeze-cursors-catppuccin.url = "github:noaccOS/breeze-cursors-catppuccin";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    user = "matthew";
  in {
    nixosConfigurations = {
      plasma = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules = [
          ./hosts/t480/configuration.nix
          ./hosts/t480/plasma.nix
        ];
      };

      hyprland = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules = [
          ./hosts/t480/configuration.nix
          ./hosts/t480/hyprland.nix
        ];
      };

      cosmic = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules = [
          ./hosts/t480/configuration.nix
          ./hosts/t480/cosmic.nix
        ];
      };
    };
  };
}
