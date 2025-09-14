{
  config,
  pkgs,
  inputs,
  ...
}: let
  catppuccinAccent = "lavender";
  catppuccinVariant = "mocha";

  breeze-cursors-catppuccin = inputs.breeze-cursors-catppuccin.packages.${pkgs.system}.default;

  catppuccinKvantum = pkgs.catppuccin-kvantum.override {
    accent = catppuccinAccent;
    variant = catppuccinVariant;
  };
in {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6ct
  ];

  gtk = {
    enable = true;

    font = {
      name = "JetBrains Mono";
      size = 12;
    };

    theme = {
      name = "catppuccin-mocha-lavender-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = [catppuccinAccent];
        size = "standard";
        variant = catppuccinVariant;
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
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  dconf.settings = {
    #"org/gnome/desktop/wm/preferences" = {
    #button-layout = ":close";
    #};
    # Dark theme for default Apps
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.file.".icons/default".source = "${breeze-cursors-catppuccin}/share/icons/Breeze_Catppuccin";

  home.sessionVariables = {
    # QT variables
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";

    # Cursor variables
    XCURSOR_THEME = "Breeze_Catppuccin";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Breeze_Catppuccin";
    HYPRCURSOR_SIZE = "24";
  };

  xdg.configFile = {
    # QT Kvantum config
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-mocha-lavender
      font=JetBrains Mono,12,-1,5,50,0,0,0,0,0
    '';
    "qt5ct/qt5ct.conf".text = ''
      [Fonts]
      general="JetBrains Mono,12,-1,5,50,0,0,0,0,0"
      [Appearance]
      icon_theme=Adwaita
    '';
    "qt6ct/qt6ct.conf".text = ''
      [Fonts]
      general="JetBrains Mono,12,-1,5,50,0,0,0,0,0"
      [Appearance]
      icon_theme=Adwaita
    '';
    "Kvantum/catppuccin-mocha-lavender".source = "${catppuccinKvantum}/share/Kvantum/catppuccin-mocha-lavender";

    # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
