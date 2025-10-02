{
  config,
  pkgs,
  ...
}: let
  # Font
  fontSize = 12;
  fontFamily = "Adwaita Sans";

  # Icon
  iconName = "Adwaita";
  iconTheme = pkgs.adwaita-icon-theme;

  # Cursor
  cursorName = "breeze_cursors";
  cursor = pkgs.kdePackages.breeze;
  cursorSize = 24;

  # GTK theme
  gtkName = "adw-gtk3-dark";
  gtkTheme = pkgs.adw-gtk3;

  # Strings
  cursorSizeString = builtins.toString cursorSize;
in {
  home.packages = with pkgs; [
    kdePackages.breeze
    adwaita-fonts
    libsForQt5.qt5ct
    qt6ct
  ];

  gtk = {
    enable = true;

    font = {
      name = fontFamily;
      size = fontSize;
    };

    theme = {
      name = gtkName;
      package = gtkTheme;
    };

    iconTheme = {
      name = iconName;
      package = iconTheme;
    };

    cursorTheme = {
      name = cursorName;
      package = cursor;
      size = cursorSize;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    #gtk4.extraConfig = {
    #  gtk-application-prefer-dark-theme = true;
    #};
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":close";
    };

    # Dark theme for default Apps
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.file.".icons/default".source = "${cursor}/share/icons/${cursorName}";

  home.sessionVariables = {
    # QT variables
    QT_QPA_PLATFORMTHEME = "kde";
    QT_STYLE_OVERRIDE = "breeze";

    # Cursor variables
    XCURSOR_THEME = cursorName;
    XCURSOR_SIZE = cursorSizeString;
    HYPRCURSOR_THEME = cursorName;
    HYPRCURSOR_SIZE = cursorSizeString;
  };

  xdg.configFile = {
    # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
