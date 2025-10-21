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

  # Dolphin fix
  environment.etc."xdg/menus/applications.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
      "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">
    <Menu>
      <Name>Applications</Name>
      <DefaultAppDirs/>
      <DefaultDirectoryDirs/>
      <DefaultMergeDirs/>
      <Include>
        <Category>Application</Category>
      </Include>
    </Menu>
  '';

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  home-manager = {
    sharedModules = [
      #../../modules/home-manager/hyprland/hyprland-rice.nix
      ../../modules/home-manager/hyprland/hyprland-minimal.nix
    ];
  };
}
