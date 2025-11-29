{ config, lib, pkgs, user, ... }:
let
  fontSizeString = builtins.toString config.theme.font.size;
  cursorSizeString = builtins.toString config.theme.cursor.size;
in
{
  options.theme = with lib; {
    enable = mkEnableOption "Enable theming";

    font = {
      family = mkOption {
        type = types.str;
        default = "Noto Sans";
      };
      size = mkOption {
        type = types.int;
        default = 10;
      };
    };

    icon = {
      name = mkOption {
        type = types.str;
        default = "Adwaita";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.adwaita-icon-theme;
      };
    };

    cursor = {
      name = mkOption {
        type = types.str;
        default = "breeze_cursors";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.kdePackages.breeze;
      };
      size = mkOption {
        type = types.int;
        default = 24;
      };
    };

    matugen = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };

    gtk = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      name = mkOption {
        type = types.str;
        default = "adw-gtk3-dark";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.adw-gtk3;
      };
    };

    qt = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };

    kvantum = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
      name = mkOption {
        type = types.str;
        default = "catppuccin-frappe-blue";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.catppuccin-kvantum;
      };
    };
  };

  config =
    with config.theme;
    lib.mkIf enable {
      home = {
        packages = with pkgs; [ ]
        ++ lib.optional  kvantum.enable kdePackages.qtstyleplugin-kvantum;

        file.".icons/default".source = "${cursor.package}/share/icons/${cursor.name}";

        sessionVariables = {
          XCURSOR_THEME = cursor.name;
          XCURSOR_SIZE = cursorSizeString;
          HYPRCURSOR_THEME = cursor.name;
          HYPRCURSOR_SIZE = cursorSizeString;
        };
      };

      gtk = lib.mkIf gtk.enable {
        enable = true;

        font = {
          name = font.family;
          size = font.size;
        };
        theme = {
          name = gtk.name;
          package = gtk.package;
        };
        iconTheme = {
          name = icon.name;
          package = icon.package;
        };
        cursorTheme = {
          name = cursor.name;
          package = cursor.package;
          size = cursor.size;
        };
      };

      dconf.settings = {
        "org/gnome/desktop/wm/preferences" = {
          #button-layout = ":minimize,maximize,close";
          button-layout = ":close";
        };
      };


      xdg.configFile = lib.mkMerge [
        (lib.mkIf qt.enable {
          "kdeglobals".text = ''
            [General]
            font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0

            ${builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"}
          '';
        })

        (lib.mkIf (gtk.enable && !matugenEnable) {
          # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
          "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
          "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
          "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
        })

        (lib.mkIf kvantum.enable {
          "kdeglobals".text = ''
            [General]
            font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
            fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          '';
          "qt5ct/qt5ct.conf".text = lib.mkForce ''
            [Fonts]
            general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
            fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
            [Appearance]
            icon_theme=${icon.name}
            custom_palette=true
            color_scheme_path=/home/${user}/.config/qt5ct/style-colors.conf
          '';
          "qt6ct/qt6ct.conf".text = lib.mkForce ''
            [Fonts]
            general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
            fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
            [Appearance]
            icon_theme=${icon.name}
            custom_palette=true
            color_scheme_path=/home/${user}/.config/qt6ct/style-colors.conf
          '';
          "Kvantum/kvantum.kvconfig".text = ''
            [General]
            theme=${kvantum.name}
            font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          '';
          "Kvantum/${kvantum.name}".source = "${kvantum.package}/share/Kvantum/${kvantum.name}";
        })
      ];

      qt = {
        enable = true;
        platformTheme.name = "kde";
        style.name = if kvantum.enable then "kvantum" else "breeze";
      };
    };
}
