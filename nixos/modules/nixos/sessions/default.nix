{ lib, ... }:
{
  imports = [
    ./cinnamon
    ./cosmic
    ./gnome
    ./hyprland
    ./niri
    ./plasma
  ];

  options.session = with lib; {
    desktop = mkOption {
      type = types.enum [ "cinnamon" "cosmic" "gnome" "hyprland" "niri" "plasma" ];
      description = "Which one DE/WM to use";
    };
  };
}
