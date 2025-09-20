{
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg # Best convertor
    fish # Shell
    libinput # List of available devices

    # Applications
    steam-run # To run godot builds
    gimp # Image editor
    telegram-desktop # Telegram client
    vesktop # Discord client
    zoom # Zoom
    godot-mono # Yeah...
    aseprite # Aseprite
    github-desktop # Github client
    obsidian # Notes
    kitty # Terminal
    obs-studio # OBS
    davinci-resolve # Davinci resolve
    prismlauncher # The Minecraft launcher
    batmon # TUI battery
    htop # TUI task manager
    audacity # Audio editor
    gamescope # Downscale games
    mpv # Media player
    reaper # Digital audio workstation

    # Fonts
    jetbrains-mono # System font
    font-awesome # Icon font
    nerd-fonts.jetbrains-mono # Nerd font
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
