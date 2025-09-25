{
  pkgs,
  user,
  config,
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
    godot-mono # Yeah...
    gamescope # Downscale games
    krita # Image editor
    telegram-desktop # Telegram client
    vesktop # Discord client
    aseprite # Aseprite
    github-desktop # Github client
    obsidian # Notes
    obs-studio # OBS
    davinci-resolve # Davinci resolve
    audacity # Audio editor
    reaper # Digital audio workstation
    prismlauncher # The Minecraft launcher
  ];

  fonts.fontconfig.enable = true;
  #home.file.".local/share/fonts".source = "/run/current-system/sw/share/X11/fonts";

  programs.home-manager.enable = true;
}
