{
  config,
  pkgs,
  inputs,
  ...
}: let
  # Font
  fontSize = 12;
  fontFamily = "NOTONOTO-Regular";

  # Icon
  iconName = "Adwaita";
  iconTheme = pkgs.adwaita-icon-theme;
  #iconName = "breeze-dark";
  #iconTheme = pkgs.kdePackages.breeze-icons;

  # Cursor
  cursorName = "Breeze_Catppuccin";
  cursor = inputs.breeze-cursors-catppuccin.packages.${pkgs.system}.default;
  cursorSize = 24;

  # Theme
  catppuccinAccent = "lavender";
  catppuccinVariant = "mocha";

  # QT theme
  kvantumName = "catppuccin-mocha-lavender";
  kvantumTheme = pkgs.catppuccin-kvantum.override {
    accent = catppuccinAccent;
    variant = catppuccinVariant;
  };

  # GTK theme
  gtkName = "catppuccin-mocha-lavender-standard+normal";
  gtkTheme = pkgs.catppuccin-gtk.override {
    accents = [catppuccinAccent];
    size = "standard";
    variant = catppuccinVariant;
    tweaks = ["normal"];
  };

  # Strings
  fontSizeString = builtins.toString fontSize;
  cursorSizeString = builtins.toString cursorSize;
in {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
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

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      #button-layout = ":close";
      button-layout = "";
    };

    # Dark theme for default Apps
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.file.".icons/default".source = "${cursor}/share/icons/${cursorName}";

  home.sessionVariables = {
    # QT variables
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";

    # Cursor variables
    XCURSOR_THEME = cursorName;
    XCURSOR_SIZE = cursorSizeString;
    HYPRCURSOR_THEME = cursorName;
    HYPRCURSOR_SIZE = cursorSizeString;
  };

  xdg.configFile = {
    # QT Kvantum config
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${kvantumName}
      font=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
    '';
    "qt5ct/qt5ct.conf".text = ''
      [Fonts]
      general="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
      [Appearance]
      icon_theme=${iconName}
    '';
    "qt6ct/qt6ct.conf".text = ''
      [Fonts]
      general="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
      [Appearance]
      icon_theme=${iconName}
    '';
    "Kvantum/${kvantumName}".source = "${kvantumTheme}/share/Kvantum/${kvantumName}";

    # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
