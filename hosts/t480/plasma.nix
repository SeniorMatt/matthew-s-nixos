{ pkgs, ... }: {
  imports = [
    # ../../modules/nixos/power-profiles-daemon.nix
    ../../modules/nixos/tlp.nix
    ../../modules/nixos/fish.nix
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
      ../../modules/home-manager/plasma/plasma-manager.nix
    ];
  };
}
