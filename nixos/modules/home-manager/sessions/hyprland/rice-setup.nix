{ lib, config, pkgs, repoPath, ... }: 
let
  wallpaper = "${repoPath}/pictures/wallpapers/catppuccin/pompeii.png";
in {
  imports = [
    ../../theming

    ../../programs/rofi
    ../../programs/nautilus
    ../../programs/waybar
    ../../programs/dunst
    ../../programs/default-apps
  ];

  config = lib.mkIf (config.hyprland.theme == "rice") {
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
      cornerRadius = config.hyprland.cornerRadius;
      theme = "catppuccin";
    };

    waybar = {
      cornerRadius = config.hyprland.cornerRadius;
      theme = "catppuccin";
      settings = "hyprland";
    };

    dunst = {
      cornerRadius = config.hyprland.cornerRadius;
    };

    kitty = {
      theme = "catppuccin";
    };

    # Wallpaper
    services.hyprpaper = {
      enable = true;
      package = pkgs.hyprpaper;
      settings = {
        preload = [ "${wallpaper}" ];
        wallpaper = [ ",${wallpaper}" ];
      };
    };

    # OSD
    services.swayosd.enable = true; 
    services.hyprpolkitagent.enable = true; # Authentification agent

    home.packages = with pkgs; [
      # System applications
      wlsunset # Blue light filter
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
  };
}
