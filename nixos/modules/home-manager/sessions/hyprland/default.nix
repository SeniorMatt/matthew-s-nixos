{ lib, ... }:
{
  imports = [
    ./minimal-setup.nix
    ./rice-setup.nix
    ./configuration/animations.nix
    ./configuration/autostart.nix
    ./configuration/binds.nix
    ./configuration/gestures.nix
    ./configuration/input.nix
    ./configuration/look-and-feel-minimal.nix
    ./configuration/look-and-feel.nix
    ./configuration/monitors.nix
    ./configuration/window-rules.nix
    ./configuration/workspaces.nix
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
