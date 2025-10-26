{
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  services.desktopManager.cosmic.enable = true;

  home-manager = {
    sharedModules = [
    ];
  };
}
