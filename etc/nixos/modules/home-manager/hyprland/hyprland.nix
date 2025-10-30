{
  pkgs,
  config,
  ...
}: let
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/catppuccin/pompeii.png";
  cornerRadius = "4";
in {
  imports = [
    ../theme.nix

    ../oh-my-posh.nix # Fish theme
    ../fastfetch.nix # Fastfetch
    ../fun.nix # Fun terminal
    ../kitty/kitty-catppuccin.nix # Terminal
    ../rofi/rofi.nix # App launcher
    ../rofi/rofi-catppuccin-theme.nix # App launcher
    ../waybar/waybar.nix # Panel
    ../dunst.nix # Notification manager
    ../default-apps.nix # Default apps

    # Hyprland
    ./animations.nix
    ./autostart.nix
    ./binds.nix
    ./input.nix
    ./look-and-feel.nix
    ./monitors.nix
    ./window-rules.nix
    ./workspaces.nix
  ];

  theme = {
    enable = true;

    # Font
    fontSize = 13;
    fontFamily = "JetBrains Mono";
    
    # Icons
    iconName = "Adwaita";
    iconTheme = pkgs.adwaita-icon-theme;

    # Cursor
    cursorName = "Bibata-Modern-Classic";
    cursorTheme = pkgs.bibata-cursors;
    cursorSize = 24;

    # GTK
    gtkEnable = true;
    gtkName = "catppuccin-mocha-lavender-standard+normal";
    gtkTheme = pkgs.catppuccin-gtk.override {
      accents = ["lavender"];
      size = "standard";
      variant = "mocha";
      tweaks = ["normal"];
    };

    # Kvantum
    kvantumEnable = true;
    kvantumName = "catppuccin-mocha-lavender";
    kvantumTheme = pkgs.catppuccin-kvantum.override {
      accent = "lavender";
      variant = "mocha";
    };
  };

  rofi = {
    inherit cornerRadius;
  };

  dunst = {
    inherit cornerRadius;
  };

  waybar = {
    inherit cornerRadius;
  };

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    hyprshot # Screenshot utility
    swayosd # Notifications for the volume and brightness
    kdePackages.kcalc # Calculator

    # Controls
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control
  ];

  xdg.configFile = {
    # Hyprpaper
    "hypr/hyprpaper.conf".text = ''
      preload = ${wallpaper}
      wallpaper= , ${wallpaper}
    '';

    # Bookmarks for File Manager
    "gtk-3.0/bookmarks".text = ''
      file:///~/Downloads Downloads
      file:///~/Documents Documents
      file:///~/Documents/GitHub GitHub
      file:///~/Pictures Pictures
      file:///~/Videos Videos
      file:///~/.local/share/Trash Trash
    '';
  };

  # Session variables
  home.sessionVariables = {
    XDG_PICTURES_DIR = "$HOME/Pictures";
    HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Auto-start for services
    xwayland.enable = true;

    # scRGB support
    settings.debug.full_cm_proto = true;
  };
}
