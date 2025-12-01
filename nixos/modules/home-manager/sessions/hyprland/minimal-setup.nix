{ lib, config, pkgs, repoPath, ... }: 
let
  wallpaper = "${repoPath}/pictures/wallpapers/the_creation_of_adam.jpg";
in {
  imports = [
    ../../theming

    ../../programs/rofi
    ../../programs/nautilus
    ../../programs/waybar
    ../../programs/dunst
    ../../programs/default-apps
  ];

  config = lib.mkIf (config.hyprland.theme == "minimal") {
    theme = {
      enable = true;
      font = {
        size = 13;
        family = "JetBrains Mono";
      };
      gtk.enable = true;
    };

    rofi = {
      cornerRadius = config.hyprland.cornerRadius;
      theme = "minimal";
    };

    waybar = {
      cornerRadius = config.hyprland.cornerRadius;
      theme = "minimal";
      settings = "hyprland";
    };

    dunst = {
      cornerRadius = config.hyprland.cornerRadius;
    };

    services.hyprpaper = {
      enable = true; # Wallpaper utility
      settings = {
        preload = [ "${wallpaper}" ];
        wallpaper = [ ",${wallpaper}" ];
      };
    };

    services.swayosd.enable = true; # OSD

    home.packages = with pkgs; [
      wlsunset # Blue light filter
      hyprpolkitagent # Authentification agent
      hyprshot # Screenshot utility
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
      settings.animations.enabled = "no";

      settings.debug.full_cm_proto = true; # scRGB support
    };
  };
}
