{ config, lib, ... }:
{
  config = lib.mkIf (config.session.desktop == "cosmic") {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    home-manager = {
      sharedModules = [
        ../../../home-manager/sessions/cosmic
      ];
    };
  };
}
