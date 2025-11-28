{ pkgs, ... }:
{
  imports = [
    ../tlp.nix
  ];

  programs.niri.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.gnome.gnome-keyring.enable = true; # Secret service
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  home-manager = {
    sharedModules = [
      ../../home-manager/niri/niri-flake.nix
    ];
  };
}
