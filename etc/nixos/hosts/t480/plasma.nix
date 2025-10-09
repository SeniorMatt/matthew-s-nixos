{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/power-profiles-daemon.nix
    inputs.home-manager.nixosModules.default
  ];

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # kdepim-runtime # Akonadi agents and resources
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
      ../../modules/home-manager/plasma/plasma-manager.nix
    ];
  };
}
