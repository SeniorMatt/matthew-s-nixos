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
      t480 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user;};
        modules = [
          ./hosts/t480/configuration.nix
          ./hosts/t480/plasma.nix
          #./hosts/t480/hyprland.nix
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs user;};
              useUserPackages = true;
              sharedModules = [
                ./modules/home-manager/fish.nix
                ./modules/home-manager/kitty.nix
                ./modules/home-manager/firefox.nix
                ./modules/home-manager/git.nix
                ./modules/home-manager/nvf.nix
                #./modules/home-manager/fun.nix
              ];
            };
          }
        ];
      };
    };
  };
}
