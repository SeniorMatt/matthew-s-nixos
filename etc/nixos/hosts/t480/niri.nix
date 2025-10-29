{
  imports = [
    ../../modules/nixos/tlp.nix
  ];

  programs.niri.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.gnome.gnome-keyring.enable = true; # Secret service
  home-manager = {
    sharedModules = [
      ../../modules/home-manager/niri/niri.nix
    ];
  };
}
