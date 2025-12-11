{ lib, ... }:
{
  imports = [
    ./cosmic
    ./gnome
    ./hyprland
    ./niri
    ./plasma
  ];

  options.session = with lib; {
    desktop = mkOption {
      type = types.enum [ "cosmic" "gnome" "hyprland" "niri" "plasma" ];
      description = "Which one DE/WM to use";
    };
  };
}
