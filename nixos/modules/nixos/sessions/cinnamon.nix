{ lib, config, ... }:
{
  config = lib.mkIf (config.session.desktop == "cinnamon") {
    services.xserver = {
      enable = true;
      videoDrivers = [ "modesetting" ];
      # videoDrivers = [ "intel" ];
      # deviceSection = ''
      #   Option "DRI" "2"
      #   Option "TearFree" "true"
      # '';
    };

    # Login manager
    services.displayManager.ly.enable = true;

    services.xserver.desktopManager.cinnamon.enable = true;
  };
}
