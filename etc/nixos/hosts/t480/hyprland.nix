{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/tlp.nix
  ];

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/hyprland/hyprland.nix
    ];
  };
}
