{
  config,
  pkgs,
  inputs,
  ...
}: let
  breeze-cursors-catppuccin = inputs.breeze-cursors-catppuccin.packages.${pkgs.system}.default;
in {
  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-lavender-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        variant = "mocha";
        tweaks = ["normal"];
      };
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Breeze_Catppuccin";
      package = breeze-cursors-catppuccin;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk";
  };

  dconf.settings = {
    #"org/gnome/desktop/wm/preferences" = {
    #button-layout = ":close";
    #};
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.file.".icons/default".source = "${breeze-cursors-catppuccin}/share/icons/Breeze_Catppuccin";

  home.sessionVariables = {
    XCURSOR_THEME = "Breeze_Catppuccin";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Breeze_Catppuccin";
    HYPRCURSOR_SIZE = "24";
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
