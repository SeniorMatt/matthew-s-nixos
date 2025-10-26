{
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;

  home-manager = {
    sharedModules = [
    ];
  };
}
