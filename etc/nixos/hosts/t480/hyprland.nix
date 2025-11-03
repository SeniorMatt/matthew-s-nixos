{ pkgs, ... }: {
  imports = [
    ../../modules/nixos/tlp.nix
    ../../modules/nixos/fish.nix
  ];

  programs.hyprland.enable = true;
  services.gvfs.enable = true;

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/hyprland/hyprland.nix
    ];
  };
}
