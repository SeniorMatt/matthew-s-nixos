{ lib, ... }:
{
  options.waybar = with lib; {
    theme = mkOption {
      type = types.enum [ "catppuccin" "matugen" "minimal" ];
      default = "minimal";
    };
    settings = mkOption {
      type = types.enum [ "niri" "hyprland" ];
      default = "niri";
    };
    cornerRadius = mkOption {
      type = types.int;
      default = 0;
    };
  };
}
