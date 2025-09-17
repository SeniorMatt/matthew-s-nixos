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
    unzip
    wget

    # Applications
    steam-run # To run godot builds
    gimp # Image editor
    telegram-desktop # Telegram client
    vesktop # Discord client
    zoom # Zoom
    godot-mono # Yeah...
    # aseprite # Aseprite
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

    # Fun stuff :D
    nitch # Fetcher
    neofetch # Fetcher N2
    pipes # Pipes
    cmatrix # Matrix effect
    cbonsai # Bonsai tree
    sl # Fucking train
    cowsay # What does the cow say?
    fortune # Fortune cookie
    asciiquarium # Ascii quarium
    cava # Audio visualizer
    tty-clock # TTY clock

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Fonts
    jetbrains-mono # System font
    font-awesome # Icon font
    nerd-fonts.jetbrains-mono # Nerd font
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
