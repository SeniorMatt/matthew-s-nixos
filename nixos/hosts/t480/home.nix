{ pkgs, user, ... }: {
  imports = [
    ../../modules/home-manager/shells/bash
    ../../modules/home-manager/programs/firefox
    ../../modules/home-manager/programs/zen-browser
    ../../modules/home-manager/programs/git
    ../../modules/home-manager/programs/nvim
    ../../modules/home-manager/programs/fastfetch
    ../../modules/home-manager/programs/fun

    ../../modules/home-manager/programs/kitty
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg # Best convertor
    unzip # Zip
    wl-clipboard # Terminal Clipboard manager
    libinput # List of available devices

    # Applications
    steam-run # To run godot builds
    dotnetCorePackages.dotnet_8.sdk # Dotnet
    godot-mono # Yeah...
    unityhub # One more time
    gamescope # Downscale games
    krita # Image editor
    telegram-desktop # Telegram client
    github-desktop # GitHub desktop
    vesktop # Discord client
    # aseprite # Aseprite
    zoom-us # Zoom client
    obsidian # Notes
    obs-studio # OBS
    davinci-resolve # Davinci resolve
    audacity # Audio editor
    prismlauncher # The Minecraft launcher
    gnome-mines # Minesweeper
    kdePackages.isoimagewriter # Iso Image Writer
    batmon # TUI battery
    btop # TUI task manager
    gnome-system-monitor # GUI task manager
    # stress # CPU, Memory and I/O stress test
    # unigine-heaven # GPU stress test
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
