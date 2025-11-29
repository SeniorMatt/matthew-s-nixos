{ pkgs, ... }: 
{
  imports = [
    ../fish.nix
  ];

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  home-manager = {
    sharedModules = [
      ../../home-manager/plasma/plasma-manager.nix
    ];
  };
}
