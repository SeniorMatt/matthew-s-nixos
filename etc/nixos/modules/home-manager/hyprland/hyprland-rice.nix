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

    ../fastfetch.nix # Fastfetch
    ../fun.nix # Fun terminal
    ../kitty.nix # Terminal
    ../rofi.nix # App launcher
    ../waybar/waybar.nix # Panel
    # ../swayncenter.nix # Notification manager
    ../dunst.nix # Notification manager

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
    fontSize = 12;
    fontFamily = "Noto Sans";
    
    # Icons
    iconName = "Adwaita";
    iconTheme = pkgs.adwaita-icon-theme;

    # Cursor
    cursorName = "breeze_cursors";
    cursorTheme = pkgs.kdePackages.breeze;
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

  waybar = {
    enable = true;
    inherit cornerRadius;
  };

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    hyprshot # Screenshot utility
    swayosd # Notifications for the volume and brightness
    yazi # TUI File manager

    # Gnome
    nautilus # File manager
    eog # Image viewer
    papers # Document viewer

    # Players
    mpv # Media player

    kdePackages.kcalc # Calculator

    # Controls
    batmon # TUI battery
    btop # TUI task manager
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control

    # Needs
    unzip # Unzip
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "application/pdf" = "org.gnome.Papers.desktop";
    };
  };

  xdg.configFile = {
    # Hyprpaper
    "hypr/hyprpaper.conf".text = ''
      preload = ${wallpaper}
      wallpaper= , ${wallpaper}
    '';

    # Bookmarks for File Manager
    "gtk-3.0/bookmarks".text = ''
      file:///home/matthew/Downloads Downloads
      file:///home/matthew/Documents Documents
      file:///home/matthew/Documents/GitHub GitHub
      file:///home/matthew/Pictures Pictures
      file:///home/matthew/Videos Videos
      file:///home/matthew/.local/share/Trash Trash
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
