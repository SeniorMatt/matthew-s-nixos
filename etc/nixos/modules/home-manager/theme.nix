{config, pkgs, lib, ...}: 
let
  fontSizeString = builtins.toString config.theme.fontSize;
  cursorSizeString = builtins.toString config.theme.cursorSize;
in {
  options.theme = with lib; {
    enable = mkEnableOption "Enable theming";

    # Font
    fontFamily = mkOption {
      type = types.str;
      default = "Noto Sans";
    };
    fontSize = mkOption {
      type = types.int;
      default = 12;
    };

    # Icons
    iconName = mkOption {
      type = types.str;
      default = "Adwaita";
    };
    iconTheme = mkOption {
      type = types.package;
      default = pkgs.adwaita-icon-theme;
    };

    # Cursor
    cursorName = mkOption {
      type = types.str;
      default = "breeze_cursors";
    };
    cursorTheme = mkOption {
      type = types.package;
      default = pkgs.kdePackages.breeze;
    };
    cursorSize = mkOption {
      type = types.int;
      default = 24;
    };

    # GTK
    #gtkEnable = mkEnableOption "Enable GTK theming";
    gtkEnable = mkOption {
      type = types.bool;
      default = true;
    };
    gtkName = mkOption {
      type = types.str;
      default = "adw-gtk3-dark";
    };
    gtkTheme = mkOption {
      type = types.package;
      default = pkgs.adw-gtk3;
    };

    # Kvantum
    #kvantumEnable = mkEnableOption "Enable Kvantum theming";
    kvantumEnable = mkOption {
      type = types.bool;
      default = false;
    };
    kvantumName = mkOption {
      type = types.str;
      default = "catppuccin-frappe-blue";
    };
    kvantumTheme = mkOption {
      type = types.package;
      default = pkgs.catppuccin-kvantum;
    };
  };

  config = with config.theme; lib.mkIf enable {
    home = {
      packages = with pkgs; [
          libsForQt5.qt5ct
          qt6ct
      ] ++ lib.optional kvantumEnable kdePackages.qtstyleplugin-kvantum;

      file.".icons/default".source = "${cursorTheme}/share/icons/${cursorName}";

      sessionVariables = {
        # Cursor variables
        XCURSOR_THEME = cursorName;
        XCURSOR_SIZE = cursorSizeString;
        HYPRCURSOR_THEME = cursorName;
        HYPRCURSOR_SIZE = cursorSizeString;

        # QT variables
        #QT_QPA_PLATFORMTHEME = "qt6ct";
        #QT_STYLE_OVERRIDE = "kvantum";
        #GTK_THEME = gtkName;
      };
    };

    gtk = lib.mkIf gtkEnable {
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
        package = cursorTheme;
        size = cursorSize;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "";
      };

      # Dark theme for default Apps
      # "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    xdg.configFile = lib.mkMerge [
      (lib.mkIf gtkEnable {
        # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
        "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      })

      (lib.mkIf kvantumEnable {
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
        custom_palette=false
      '';
      "qt6ct/qt6ct.conf".text = ''
        [Fonts]
        general="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
        [Appearance]
        icon_theme=${iconName}
        custom_palette=false
      '';

      "Kvantum/${kvantumName}".source = "${kvantumTheme}/share/Kvantum/${kvantumName}";
      })
    ];

    qt = {
      enable = true;
      #platformTheme.name = if kvantumEnable then "qt6ct" else "kde";
      platformTheme = { name = if kvantumEnable then "qt6ct" else "kde"; };
      style =  { name = if kvantumEnable then "kvantum" else "breeze"; };
    };
  };
}
