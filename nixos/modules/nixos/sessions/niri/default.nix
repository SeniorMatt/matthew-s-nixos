{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.session.desktop == "niri") {
    programs.niri.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.gnome.gnome-keyring.enable = true; # Secret service
    services.displayManager.ly.enable = true; # Login manager
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
    home-manager = {
      sharedModules = [
        ../../../home-manager/sessions/niri
      ];
    };
  };
}
