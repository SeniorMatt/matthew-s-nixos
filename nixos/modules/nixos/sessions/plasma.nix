{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.session.desktop == "plasma") {

    services.desktopManager.plasma6.enable = true; # KDE Plasma desktop
    services.displayManager.ly.enable = true; # Login manager

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration # Buggy browser integration
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde # Portal
      ];
    };

    home-manager = {
      sharedModules = [
        ../../home-manager/sessions/plasma # Home manager module
      ];
    };
  };
}
