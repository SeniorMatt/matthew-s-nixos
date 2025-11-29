{ config, lib, ... }:
{
  config = lib.mkIf (config.session.desktop == "cosmic") {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.ly.enable = false;

    home-manager = {
      sharedModules = [
        ../../home-manager/cosmic/cosmic.nix
      ];
    };
  };
}
