{ pkgs, user, ... }: 
let
  wallpaper = "/home/${user}/Pictures/wallpapers/the_creation_of_adam.jpg";
  cornerRadius = "0";
in {
  imports = [
    ../theme.nix

    ../fastfetch.nix # Fastfetch
    ../fun.nix # Fun terminal
    ../kitty/kitty.nix # Terminal
    ../rofi/rofi.nix # App launcher
    ../rofi/rofi-minimal-theme.nix # App launcher
    ../nautilus.nix
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
    fontSize = 13;
    fontFamily = "JetBrains Mono";
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

  # Wallpapers
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpolkitagent # Authentification agent
    hyprshot # Screenshot utility
    swayosd # Notifications for the volume and brightness
    kdePackages.dolphin # 

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
    settings.animations.enabled = "no";

    # scRGB support
    settings.debug.full_cm_proto = true;
  };
}
