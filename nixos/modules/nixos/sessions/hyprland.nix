{ pkgs, ... }: {
  imports = [
    ../tlp.nix
    ../fish.nix
  ];

  programs.hyprland.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
