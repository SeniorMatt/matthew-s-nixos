{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./theme-catppuccin.nix
  ];

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    tofi # App launcher
    waybar # Panel
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    xdg-desktop-portal-hyprland # Desktop portal hyprland
    swayosd # Notifications for the volume and brightness

    # Gnome ecosystem
    evince # Document viewer
    nautilus # File manager
    eog # Image viewer
    papers # Document viewer
    parlatype # Audio player
    gnome-calculator # Calculator
    gnome-clocks # Clock

    # Needs
    blueman # Bluetooth control
    blueberry # Another bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control
    grim # Screenshot
    slurp # Selector for screenshot
  ];
}
