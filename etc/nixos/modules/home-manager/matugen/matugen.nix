{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.matugen.nixosModules.default
  ];

  home.packages = with pkgs; [ matugen ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/kitty-kate.png";

    templates = {
      waybar = {
        input_path = ./templates/colors.css;
        output_path = "$HOME/.config/waybar/colors.css";
      };
      kitty = {
        input_path  = ./templates/kitty-colors.conf;
        output_path = "$HOME/.config/kitty/colors.conf";
      };
    };
  };

  home.file.".config/kitty/kitty-colors.conf".source = "${config.programs.matugen.theme.files}/.config/kitty/kitty-colors.conf";
  # xdg.configFile = {
  #   "matugen/config.toml".text = ''
  #     [config]
  #     [templates.gtk]
  #     input_path = '/etc/nixos/modules/home-manager/matugen/templates/gtk.css'
  #     output_path = '~/.config/gtk-4.0/gtk-colors.css'
  #     [templates.waybar]
  #     [templates.kitty]
  #     input_path = '/etc/nixos/modules/home-manager/matugen/templates/kitty-colors.conf'
  #     output_path = '~/.config/kitty/kitty-colors.conf'
  #     [templates.rofi]
  #     input_path = '/etc/nixos/modules/home-manager/matugen/templates/rofi-colors.rasi'
  #     output_path = '~/.config/rofi/rofi-colors.rasi'
  #   '';
  #   "gtk-4.0/gtk.css" = {
  #     text = ''@import url("file:///home/${user}/.config/gtk-4.0/gtk-colors.css"); '';
  #     force = true;
  #   };
  #
  #   # You might will need to manually rm -f .config/gtk-4.0/gtk.css
  # };
}
