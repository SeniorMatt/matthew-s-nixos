{ config, pkgs, repoPath, ... }: 
let
  wallpaper = "${repoPath}/pictures/wallpapers/the_creation_of_adam.jpg";
  cornerRadius = builtins.toString config.hyprland.cornerRadius;
in {
  imports = [
    ../../theming

    ../../programs/rofi
    ../../programs/nautilus
    ../../programs/waybar
    ../../programs/dunst

    ../../default-apps.nix # Default apps

    # Hyprland
    ./configuration/autostart.nix
    ./configuration/binds.nix
    ./configuration/gestures.nix
    ./configuration/input.nix
    ./configuration/look-and-feel-minimal.nix
    ./configuration/monitors.nix
    ./configuration/smart-gaps.nix
    ./configuration/window-rules.nix
    ./configuration/workspaces.nix
  ];

  theme = {
    enable = true;
    font = {
      size = 13;
      family = "JetBrains Mono";
    };
  };

  rofi = {
    inherit cornerRadius;
    theme = "minimal";
  };

  waybar = {
    inherit cornerRadius;
    theme = "minimal";
    settings = "hyprland";
  };

  dunst = {
    inherit cornerRadius;
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
}
