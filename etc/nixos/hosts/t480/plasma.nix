{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.default];

  services.desktopManager.plasma6.enable = true;

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/plasma.nix
    ];
  };
}
