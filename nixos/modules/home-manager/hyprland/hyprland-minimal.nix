{ pkgs, repoPath, ... }: 
let
  wallpaper = "${repoPath}/pictures/wallpapers/the_creation_of_adam.jpg";
  cornerRadius = "0";
in {
  imports = [
    ../theme.nix

    ../rofi/rofi.nix # App launcher
    ../rofi/rofi-minimal-theme.nix # App launcher
    ../nautilus.nix # File manager
    ../waybar/waybar-hyprland.nix # Panel
    ../waybar/waybar-minimal-theme.nix # Minimal theme for panel
    ../dunst.nix # Notification manager
    ../default-apps.nix # Default apps

    # Hyprland
    ./autostart.nix
    ./binds.nix
    ./gestures.nix
    ./input.nix
    ./look-and-feel-minimal.nix
    ./monitors.nix
    ./smart-gaps.nix
    ./window-rules.nix
    ./workspaces.nix
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
  };

  dunst = {
    inherit cornerRadius;
  };

  waybar = {
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
