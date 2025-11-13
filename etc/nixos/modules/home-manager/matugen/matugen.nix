{ config, inputs, pkgs, user, lib, ... }:
let
  templateFolder = "/etc/nixos/modules/home-manager/matugen/templates";
in {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  options.matugen = with lib; {
    wallpaper = mkOption {
      type = types.str;
    };
  };

  config = with config.matugen;  {
    programs.matugen = {
      enable = true;
      variant = "dark";
      jsonFormat = "hex";
      wallpaper = "${wallpaper}";

      # templates = {
      #   waybar = {
      #     input_path = ./templates/colors.css;
      #     output_path = "$HOME/.config/waybar/colors.css";
      #   };
      #   kitty = {
      #     input_path  = ./templates/kitty-colors.conf;
      #     output_path = "$HOME/.config/kitty/colors.conf";
      #   };
      # };
      # templates = matugenTemplates;
    };

    # home.file.".config/kitty/kitty-colors.conf".source = "${config.programs.matugen.theme.files}/.config/kitty/kitty-colors.conf";

    home.activation.run-matugen-once = ''
      ${pkgs.matugen}/bin/matugen image ${wallpaper}
    '';

    home.packages = with pkgs; [ matugen ];

    xdg.configFile = {
      "matugen/config.toml".text = ''
        [config]
        [templates.gtk]
        input_path = '${templateFolder}/gtk.css'
        output_path = '~/.config/gtk-4.0/gtk-colors.css'
        [templates.kitty]
        input_path = '${templateFolder}/kitty-colors.conf'
        output_path = '~/.config/kitty/kitty-colors.conf'
        [templates.rofi]
        input_path = '${templateFolder}/rofi-colors.rasi'
        output_path = '~/.config/rofi/rofi-colors.rasi'
        [templates.waybar]
        input_path = '${templateFolder}/colors.css'
        output_path = '~/.config/waybar/colors.css'
      '';
      "gtk-4.0/gtk.css" = {
        text = ''@import url("file:///home/${user}/.config/gtk-4.0/gtk-colors.css"); '';
        force = true;
      };

      # You might will need to manually rm -f .config/gtk-4.0/gtk.css
    };
  };
}
