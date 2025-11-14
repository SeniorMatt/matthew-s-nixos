{ pkgs, user, ... }: 
let
  wallpaper = "/home/${user}/Pictures/wallpapers/catppuccin/pompeii.png";
  cornerRadius = "4";
in {
  imports = [
    ../theme.nix

    ../oh-my-posh.nix # Fish theme
    ../fastfetch.nix # Fastfetch
    ../fun.nix # Fun terminal
    ../kitty/kitty.nix # Terminal
    ../kitty/kitty-catppuccin-theme.nix # Terminal theme
    ../rofi/rofi.nix # App launcher
    ../rofi/rofi-catppuccin-theme.nix # App launcher
    ../nautilus.nix
    ../waybar/waybar-hyprland.nix # Panel
    ../waybar/waybar-catppuccin-theme.nix # Catppuccin theme for panel
    ../dunst.nix # Notification manager
    ../default-apps.nix # Default apps

    # Hyprland
    ./animations.nix
    ./autostart.nix
    ./binds.nix
    ./gestures.nix
    ./input.nix
    ./look-and-feel.nix
    ./monitors.nix
    ./window-rules.nix
    ./workspaces.nix
  ];

  theme = {
    enable = true;

    # Font
    font = { 
      size = 13;
      family = "JetBrains Mono";
    };
    
    # Icons
    icon = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    # Cursor
    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # GTK
    gtk = {
      enable = true;
      name = "catppuccin-mocha-lavender-standard+normal";
      package = pkgs.catppuccin-gtk.override { 
        accents = ["lavender"];
        size = "standard";
        variant = "mocha";
        tweaks = ["normal"];
      };
    };

    kvantum = {
      enable = true;
      name = "catppuccin-mocha-lavender";
      package = pkgs.catppuccin-kvantum.override {
        accent = "lavender";
        variant = "mocha";
      };
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

  # Wallpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };

  # OSD
  services.swayosd.enable = true; 

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpolkitagent # Authentification agent
    hyprshot # Screenshot utility

    # Controls
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control
  ];

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
