{
  programs.niri.enable = true;

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/niri/niri.nix
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
