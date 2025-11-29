{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf?ref=v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:AlexNabokikh/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    user = "matthew";
  in {
    nixosConfigurations = {
      system = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules = [
          ./hosts/t480/configuration.nix

          # Cosmic
          ./modules/nixos/sessions/cosmic.nix

          # Plasma
          # ./modules/nixos/sessions/plasma.nix

          # Hyprland
          # ./modules/nixos/sessions/hyprland.nix
          # { home-manager.sharedModules = [ ./modules/home-manager/hyprland/hyprland-rice.nix ]; }
          # { home-manager.sharedModules = [ ./modules/home-manager/hyprland/hyprland-minimal.nix ]; }

          # Niri
          # ./modules/nixos/sessions/niri.nix

          # Cinnamon
          # ./modules/nixos/sessions/cinnamon.nix
        ];
      };
    };
  };
}
