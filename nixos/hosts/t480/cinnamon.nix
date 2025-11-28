{
  services.xserver = {
    enable = true;
    # videoDrivers = [ "modesetting" ];
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
    '';
  };
  services.xserver.desktopManager.cinnamon.enable = true;
}
