{ config, lib, pkgs, user, repoPath, ... }:
let
  fontSizeString = builtins.toString config.theme.font.size;
  cursorSizeString = builtins.toString config.theme.cursor.size;
  needsPath = "${repoPath}/.needs/";
in
{
  options.theme = with lib; {
    enable = mkEnableOption "Enable theming";

    font = {
      size = mkOption {
        type = types.int;
        default = 10;
      };
      family = mkOption {
        type = types.str;
        default = "Noto Sans";
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
        # default = "Adwaita-dark";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.adw-gtk3;
        # default = pkgs.gnome-themes-extra;
      };
      dark = mkOption {
        type = types.bool;
        default = true;
      };
      buttons = mkOption {
        type = types.enum [ "gnome" "all" ];
        default = "gnome";
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

  config = with config.theme; lib.mkIf enable {
      home = {
        packages = with pkgs; [ ]
        ++ lib.optional kvantum.enable kdePackages.qtstyleplugin-kvantum;

        file.".icons/default".source = "${cursor.package}/share/icons/${cursor.name}";

        sessionVariables = {
          XCURSOR_THEME = cursor.name;
          XCURSOR_SIZE = cursorSizeString;
          HYPRCURSOR_THEME = cursor.name;
          HYPRCURSOR_SIZE = cursorSizeString;
          ADW_DEBUG_COLOR_SCHEME = lib.mkIf gtk.dark "prefer-dark";
        };

        activation = {
          copy-kde = lib.mkIf qt.enable ''
            cp -f ${needsPath}/kdeglobals /home/${user}/.config/kdeglobals
          '';
          copy-gtk = lib.mkIf gtk.enable ''
            cp -fr ${needsPath}/gtk-4.0 /home/${user}/.config/gtk-4.0
          '';
          copy-qt = lib.mkIf kvantum.enable ''
            cp -fr ${needsPath}/qt5ct /home/${user}/.config/qt5ct
            cp -fr ${needsPath}/qt6ct /home/${user}/.config/qt6ct
          '';
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
        gtk3.extraConfig."gtk-application-prefer-dark-theme" = lib.mkIf gtk.dark 1;
        gtk4.extraConfig."gtk-application-prefer-dark-theme" = lib.mkIf gtk.dark 1;
      };

      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/wm/preferences" = if gtk.buttons == "gnome" 
            then { button-layout = ":close"; } 
            else { button-layout = ":minimize,maximize,close"; };
          
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      };

      home.file = {
        "${needsPath}/kdeglobals".text = lib.mkIf (!kvantum.enable) ''
          [General]
          font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
          fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0

          ${builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"}
        '';

        # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
        "${needsPath}/gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        "${needsPath}/gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        "${needsPath}/gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";

        # "${repoPath}/.needs/kdeglobals".text = lib.mkIf kvantum.enable lib.mkForce ''
        #   [General]
        #   font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        # '';
        "${needsPath}/qt5ct/qt5ct.conf".text = lib.mkForce ''
          [Fonts]
          general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
          fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
          [Appearance]
          icon_theme=${icon.name}
          custom_palette=true
          color_scheme_path=/home/${user}/.config/qt5ct/style-colors.conf
        '';
        "${needsPath}/qt6ct/qt6ct.conf".text = lib.mkForce ''
          [Fonts]
          general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
          fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
          [Appearance]
          icon_theme=${icon.name}
          custom_palette=true
          color_scheme_path=/home/${user}/.config/qt6ct/style-colors.conf
        '';
        ".config/Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=${kvantum.name}
          font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        '';
        ".config/Kvantum/${kvantum.name}".source = "${kvantum.package}/share/Kvantum/${kvantum.name}";
      };

      # xdg.configFile = lib.mkMerge [
        # (lib.mkIf qt.enable {
        #   "custom-kdeglobals".text = ''
        #     [General]
        #     font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #
        #     ${builtins.readFile "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors"}
        #   '';
        #   # "kdeglobals".source = config.lib.file.mkOutOfStoreSymlink "/home/matthew/.config/kdeglobals-dark";
        # })
        #
        # (lib.mkIf (gtk.enable && !matugen.enable) {
        #   # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
        #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
        # })

        # (lib.mkIf kvantum.enable {
        #   "kdeglobals".text = ''
        #     [General]
        #     font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     menuFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     toolBarFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     windowTitleFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     smallestReadableFont=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #     fixed=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   '';
        #   "qt5ct/qt5ct.conf".text = lib.mkForce ''
        #     [Fonts]
        #     general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
        #     fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
        #     [Appearance]
        #     icon_theme=${icon.name}
        #     custom_palette=true
        #     color_scheme_path=/home/${user}/.config/qt5ct/style-colors.conf
        #   '';
        #   "qt6ct/qt6ct.conf".text = lib.mkForce ''
        #     [Fonts]
        #     general="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
        #     fixed="${font.family},${fontSizeString},-1,5,50,0,0,0,0,0"
        #     [Appearance]
        #     icon_theme=${icon.name}
        #     custom_palette=true
        #     color_scheme_path=/home/${user}/.config/qt6ct/style-colors.conf
        #   '';
        #   "Kvantum/kvantum.kvconfig".text = ''
        #     [General]
        #     theme=${kvantum.name}
        #     font=${font.family},${fontSizeString},-1,5,50,0,0,0,0,0
        #   '';
        #   "Kvantum/${kvantum.name}".source = "${kvantum.package}/share/Kvantum/${kvantum.name}";
        # })
      # ];

      qt = {
        enable = true;
        platformTheme.name = "kde";
        style.name = if kvantum.enable then "kvantum" else "breeze";
      };
    };
}
