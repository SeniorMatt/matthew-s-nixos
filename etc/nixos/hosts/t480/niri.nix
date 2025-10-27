{
  imports = [
    ../../modules/nixos/tlp.nix
  ];

  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/niri/niri.nix
    ];
  };
}
