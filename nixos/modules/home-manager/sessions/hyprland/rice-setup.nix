{ config, pkgs, user, ... }: 
let
  wallpaper = "/home/${user}/Pictures/wallpapers/catppuccin/pompeii.png";
  cornerRadius = builtins.toString config.hyprland.cornerRadius;
in {
  imports = [
    ../../theming

    ../../oh-my-posh.nix # Bash theme
    ../../programs/rofi
    ../../programs/nautilus
    ../../programs/waybar
    ../../programs/dunst
    ../../default-apps.nix # Default apps

    # Hyprland
    ./configuration/animations.nix
    ./configuration/autostart.nix
    ./configuration/binds.nix
    ./configuration/gestures.nix
    ./configuration/input.nix
    ./configuration/look-and-feel.nix
    ./configuration/monitors.nix
    ./configuration/window-rules.nix
    ./configuration/workspaces.nix
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
    theme = "catppuccin";
  };

  waybar = {
    inherit cornerRadius;
    theme = "catppuccin";
    settings = "hyprland";
  };

  dunst = {
    inherit cornerRadius;
  };

  kitty = {
    theme = "catppuccin";
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
}
