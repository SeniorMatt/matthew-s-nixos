{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/nixos/bluetooth.nix
    ./modules/nixos/pipewire.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Davinci resolve CPU settings
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
    ];
  };

  # Define your hostname.
  networking.hostName = "nixos";

  # Experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Authentication polkit
  security.polkit.enable = true;

  # Disable the X11 windowing system.
  services.xserver.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matthew = {
    isNormalUser = true;
    description = "Matthew";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      "matthew" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable Fish shell
  programs.fish.enable = true;

  # Install Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    hyprland # WM
    ly # Login manager
    udiskie # Disk manager
    wl-clipboard # Clipboard manager
    lm_sensors # Temperature sensors
    brightnessctl # Brightness control
    dunst # Notifications daemon
    gnome-keyring # Keyring daemon
    zoxide # Moving in terminal
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono # System font
    font-awesome # Icon font
    nerd-fonts.jetbrains-mono # Nerd font
  ];

  # LM
  services.displayManager.ly.enable = true;

  # Hyprland
  programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Kde connect
  programs.kdeconnect.enable = true;

  # List services that you want to enable:
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;

  # Clean the old builds
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "25.11";
}
