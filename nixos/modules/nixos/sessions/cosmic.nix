{
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;

  home-manager = {
    sharedModules = [
      ../../home-manager/cosmic/cosmic.nix
    ];
  };
}
