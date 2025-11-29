{ lib, ... }:
{
  imports = [
    ./cinnamon.nix
    ./cosmic.nix
    ./gnome.nix
    ./hyprland.nix
    ./niri.nix
    ./plasma.nix
  ];

  options.session = with lib; {
    desktop = mkOption {
      type = types.enum [ "cinnamon" "cosmic" "gnome" "hyprland" "niri" "plasma" ];
      description = "Which one DE/WM to use";
    };
    flavour = mkOption {
      type = types.str;
      default = "none";
      description = "Set additional theme's flavour if it is available";
    };
  };
}
