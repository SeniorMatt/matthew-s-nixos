{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
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
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf?ref=v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # DaVinci Resolve fix
    # nixpkgs-ee930f975.url = "github:nixos/nixpkgs/ee930f9755f58096ac6e8ca94a1887e0534e2d81";
    nixpkgs-c5ae371f1.url = "github:nixos/nixpkgs/0c3fc1cd3494aa52a2c111d5f18a7689fd15ab83";
    # c5ae371f1 a6a7fd27823bc500d9390b38c05fa55
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    user = "matthew";
    repoPath = "/home/${user}/Matthew-s-NixOS";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user repoPath;};
        modules = [
          ./hosts/t480/configuration.nix
          ./modules/nixos/sessions
          { session.desktop = "plasma"; }
        ];
      };
    };
  };
}
