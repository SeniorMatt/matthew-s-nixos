{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Themes
    (catppuccin-kvantum.override { variant = "mocha"; accent = "blue"; } ) # QT theme
    adwaita-icon-theme          # Icon theme
    bibata-cursors              # Cursor theme
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum

    # System applications
    wlsunset                    # Blue light filter
    tofi                        # App launcher
    waybar                      # Panel
    wlogout                     # Logout menu
    hyprlock                    # Lock manager
    hyprpaper                   # Wallpaper
    hyprpolkitagent		# Authentification agent
    xdg-desktop-portal-hyprland	# Desktop portal hyprland

    # Gnome ecosystem
    evince                      # Document viewer
    nautilus                    # File manager
    eog                         # Image viewer
    papers                      # Document viewer
    parlatype                   # Audio player
    gnome-calculator            # Calculator
    gnome-clocks                # Clock

    # Needs
    blueberry                   # Bluetooth control
    networkmanagerapplet        # Network control
    pavucontrol                 # Audio control
    grim                        # Screenshot
    slurp                       # Selector for screenshot
  ];

  # GTK theme
  catppuccin.gtk.enable = true;
  catppuccin.gtk.flavor = "mocha";
  catppuccin.gtk.accent = "lavender";
  catppuccin.gtk.tweaks = [ "normal" ];
  catppuccin.gtk.size = "compact";

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":close";
    };
  };

  # QT theme
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "catppuccin-mocha-blue";
  };

  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    Appearance.icon_theme = "Adwaita";
  };

  # Mouse cursor
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Bibata-Modern-Classic
  '';

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
    QT_STYLE_OVERRIDE="kvantum";
  };
}
