{
  pkgs,
  user,
  ...
}: {
  imports = [
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/nvf.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg # Best convertor
    fish # Shell
    unzip # Zip
    wl-clipboard # Terminal Clipboard manager
    libinput # List of available devices

    # Applications
    steam-run # To run godot builds
    dotnetCorePackages.dotnet_8.sdk # Dotnet
    godot-mono # Yeah...
    unityhub # One more time
    vscode # VSCode
    gamescope # Downscale games
    krita # Image editor
    telegram-desktop # Telegram client
    vesktop # Discord client
    aseprite # Aseprite
    zoom-us # Zoom client
    github-desktop # Github client
    obsidian # Notes
    obs-studio # OBS
    davinci-resolve # Davinci resolve
    audacity # Audio editor
    reaper # Digital audio workstation
    prismlauncher # The Minecraft launcher
    kdePackages.isoimagewriter # Iso Image Writer
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
