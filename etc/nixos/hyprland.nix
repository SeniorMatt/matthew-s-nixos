{ config, pkgs, inputs, ... }:

let
  bibataCursorDefault = pkgs.runCommandLocal "bibata-cursor-default-theme" { } ''
    mkdir -p $out/share/icons
    # point “default” at the Classic variant
    ln -s ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic \
          $out/share/icons/default
  '';
in
{
  home.packages = with pkgs; [
    # Themes
    adwaita-icon-theme          # Icon theme
    bibata-cursors              # Cursor theme
    bibataCursorDefault		# The worst way to setup cursor
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # System applications
    wlsunset                    # Blue light filter
    tofi                        # App launcher
    waybar                      # Panel
    wlogout                     # Logout menu
    hyprlock                    # Lock manager
    hyprpaper                   # Wallpaper
    hyprpolkitagent		# Authentification agent
    xdg-desktop-portal-hyprland	# Desktop portal hyprland
    swayosd			# Notifications for the volume and brightness

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

  # Theme
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "lavender";

  catppuccin.gtk.enable = true;
  catppuccin.gtk.flavor = "mocha";
  catppuccin.gtk.accent = "lavender";
  catppuccin.gtk.tweaks = [ "normal" ];
  catppuccin.gtk.size = "compact";

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

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

  # Mouse cursor
  home.file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
}
