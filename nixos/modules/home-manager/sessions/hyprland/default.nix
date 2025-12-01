{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./minimal-setup.nix
    ./rice-setup.nix
  ];

  options.hyprland = with lib; {
    theme = mkOption {
      type = types.enum [ "minimal" "rice" ];
      default = "rice";
    };
    cornerRadius = mkOption {
      type = types.int;
      default = 4;
    };
  };
}
