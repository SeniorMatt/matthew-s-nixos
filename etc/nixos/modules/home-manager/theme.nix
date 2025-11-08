{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  fontSizeString = builtins.toString config.theme.fontSize;
  cursorSizeString = builtins.toString config.theme.cursorSize;
in
{
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

    qtEnable = mkOption {
      type = types.bool;
      default = true;
    };
    # Kvantum
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

  config =
    with config.theme;
    lib.mkIf enable {
      home = {
        packages = with pkgs; lib.mkIf kvantumEnable [ kdePackages.qtstyleplugin-kvantum ];

        file.".icons/default".source = "${cursorTheme}/share/icons/${cursorName}";

        sessionVariables = {
          XCURSOR_THEME = cursorName;
          XCURSOR_SIZE = cursorSizeString;
          HYPRCURSOR_THEME = cursorName;
          HYPRCURSOR_SIZE = cursorSizeString;
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
          #button-layout = ":minimize,maximize,close";
          button-layout = ":close";
        };
      };


      xdg.configFile = lib.mkMerge [
        (lib.mkIf qtEnable {
          "kdeglobals".text = ''
            [General]
            font=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            menuFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            toolBarFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            windowTitleFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            smallestReadableFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            fixed=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0

            ${builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"}
          '';
        })

        (lib.mkIf gtkEnable {
          # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
          "gtk-4.0/assets".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
          "gtk-4.0/gtk.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
          "gtk-4.0/gtk-dark.css".source =
            "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
        })

        (lib.mkIf kvantumEnable {
          "kdeglobals".text = ''
            [General]
            font=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            menuFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            toolBarFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            windowTitleFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            smallestReadableFont=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
            fixed=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
          '';
          "qt5ct/qt5ct.conf".text = lib.mkForce ''
            [Fonts]
            general="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
            fixed="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
            [Appearance]
            icon_theme=${iconName}
            custom_palette=true
            color_scheme_path=/home/${user}/.config/qt5ct/style-colors.conf
          '';
          "qt6ct/qt6ct.conf".text = lib.mkForce ''
            [Fonts]
            general="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
            fixed="${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0"
            [Appearance]
            icon_theme=${iconName}
            custom_palette=true
            color_scheme_path=/home/${user}/.config/qt6ct/style-colors.conf
          '';
          "Kvantum/kvantum.kvconfig".text = ''
            [General]
            theme=${kvantumName}
            font=${fontFamily},${fontSizeString},-1,5,50,0,0,0,0,0
          '';
          "Kvantum/${kvantumName}".source = "${kvantumTheme}/share/Kvantum/${kvantumName}";
        })
      ];

      qt = {
        enable = true;
        platformTheme.name = "kde";
        style.name = if kvantumEnable then "kvantum" else "breeze";
      };
    };
}
