{
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };
  services.displayManager.cosmic-greeter.enable = true;
  services.displayManager.ly.enable = false;

  home-manager = {
    sharedModules = [
      ../../home-manager/cosmic/cosmic.nix
    ];
  };
}
