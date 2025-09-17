{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.default];

  programs.hyprland.enable = true;

  home-manager = {
    sharedModules = [
      ../../modules/home-manager/hyprland.nix
    ];
  };
}
