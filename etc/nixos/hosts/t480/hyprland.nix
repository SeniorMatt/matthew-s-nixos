{ pkgs, ... }: {
  imports = [
    ../../modules/nixos/tlp.nix
    ../../modules/nixos/fish.nix
  ];

  programs.hyprland.enable = true;

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/hyprland/hyprland.nix
    ];
  };
}
