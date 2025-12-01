{ lib, ... }:
{
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
