{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    breeze-cursors-catppuccin.url = "github:noaccOS/breeze-cursors-catppuccin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
                ./modules/home-manager/hyprland.nix
              ];
            };
          }
        ];
      };
    };
  };
}
