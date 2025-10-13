{
  config,
  pkgs,
  ...
}: let
  # Font
  fontSize = 12;
  fontFamily = "Noto Sans";

  # Icon
  iconName = "breeze-dark";
  iconTheme = pkgs.kdePackages.breeze-icons;

  # Banana cursor
  #bananaCursor = pkgs.stdenvNoCC.mkDerivation {
  #  pname = "banana-cursor";
  #  version = "1.0";
  #  src = pkgs.fetchzip {
  #    url = "https://github.com/ful1e5/banana-cursor/releases/download/v2.0.0/Banana.tar.xz";
  #    sha256 = "sha256-5RvijRfPRl9d/WqQxfu9K/omFzYm5ZBTZ5wWIJnH0V0=";
  #    stripRoot = false;
  #  };
  #  installPhase = ''
  #    mkdir -p $out/share/icons
  #    cp -r "$src"/* "$out/share/icons/"
  #  '';
  #};
  #cursorName = "Banana";
  #cursor = bananaCursor;

  # Cursor
  cursorName = "breeze_cursors";
  cursor = pkgs.kdePackages.breeze;
  cursorSize = 24;

  # GTK theme
  gtkName = "Breeze-Dark";
  gtkTheme = pkgs.kdePackages.breeze-gtk;

  # Strings
  cursorSizeString = builtins.toString cursorSize;
in {
  home.packages = with pkgs; [
    kdePackages.breeze
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
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  dconf.settings = {
    #"org/gnome/desktop/wm/preferences" = {
    #  button-layout = "";
    #};

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
