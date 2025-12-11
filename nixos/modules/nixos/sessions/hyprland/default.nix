{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.session.desktop == "hyprland") {

    programs.hyprland.enable = true; # Hyprland wayland compositor

    security.polkit.enable = true; # Polkit

    services.displayManager.ly.enable = true; # Login manager

    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland:

    services.udisks2.enable = true; # Disks

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland # Hyprland's portal
        xdg-desktop-portal-gtk # GTK's portal
      ];
    };

    home-manager = {
      sharedModules = [ 
        ../../../home-manager/sessions/hyprland
        ({ 
          hyprland = {
            theme = "rice";
            cornerRadius = 8;
          };
        })
      ];
    };
  };
}
