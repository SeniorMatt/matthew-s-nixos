{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    (final: _: {
      # this allows you to access `pkgs.unstable` anywhere in your config
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    ffmpeg 			# Best convertor
    fish			# Shell
    unzip
    wget
    gcc

    # Applications
    gimp 			# Image editor
    youtube-music 		# Youtube music client
    telegram-desktop            # Telegram client
    vesktop                     # Discord client
    zoom                        # Zoom
    unityhub                    # Unity
    godot-mono                  # Yeah...
    aseprite                    # Aseprite
    github-desktop              # Github client
    obsidian                    # Notes
    kitty                       # Terminal
    obs-studio                  # OBS
    davinci-resolve             # Davinci resolve
    prismlauncher 		# The Minecraft launcher
    batmon                      # TUI battery
    htop                        # TUI task manager
    unstable.audacity		# Audio editor
    gamescope			# Downscale games
    # mesa			# Mesa Intel drivers

    # Needs
    blueberry                   # Bluetooth control
    pavucontrol                 # Audio control
    grim                        # Screenshot
    slurp                       # Selector for screenshot

    # Gnome ecosystem
    evince                      # Document viewer
    networkmanagerapplet        # Network control
    nautilus                    # File manager
    eog                         # Image viewer
    papers                      # Document viewer
    mpv                         # Media player
    parlatype                   # Audio player
    gnome-calculator            # Calculator
    gnome-clocks                # Clock

    # System applications
    wlsunset                    # Blue light filter
    tofi                        # App launcher
    waybar                      # Panel
    wlogout                     # Logout menu
    hyprlock                    # Lock manager
    hyprpaper                   # Wallpaper
    xdg-desktop-portal-hyprland	# Desktop portal hyprland
    # xdg-desktop-portal		# Dekstop portal

    # Themes
    (catppuccin-kvantum.override{
      variant = "mocha";
      accent = "lavender";
    }) # QT theme
    adwaita-icon-theme          # Icon theme
    bibata-cursors              # Cursor theme

    libsForQt5.qt5ct		
    libsForQt5.qtstyleplugin-kvantum

    # Fun stuff :D
    nitch                       # Fetcher
    neofetch                    # Fetcher N2
    pipes                       # Pipes
    cmatrix                     # Matrix effect
    cbonsai			# Bonsai tree
    sl 				# Fucking train
    cowsay 			# What does the cow say?
    fortune 			# Fortune cookie
    asciiquarium                # Ascii quarium
    cava                        # Audio visualizer

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
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      pkgs.vimPlugins.catppuccin-vim
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
  };

  programs.git = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  # GTK theme
  imports = [inputs.catppuccin.homeModules.catppuccin];

  catppuccin.gtk.enable = true;
  catppuccin.gtk.flavor = "mocha";
  catppuccin.gtk.accent = "lavender";
  # catppuccin.gtk.size = "compact";
  catppuccin.gtk.tweaks = [ "normal" ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };
  };

  # QT theme
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "catppuccin-mocha-lavender";
  };

  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    Appearance.icon_theme = "Adwaita";
  };

  # Mouse cursor
  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Bibata-Modern-Classic
  '';


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/matthew/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    QT_QPA_PLATFORMTHEME="qt5ct";
    QT_STYLE_OVERRIDE="kvantum";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "org.gnome.parlatype.desktop";
      "audio/wav" = "org.gnome.parlatype.desktop";
      "document/pdf" = "papers.desktop";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
