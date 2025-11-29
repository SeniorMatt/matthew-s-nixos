{ pkgs, user, inputs, ... }: let
  customFont = pkgs.callPackage ../../modules/nixos/custom-font.nix {};
in {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/undervolt.nix
    ../../modules/nixos/tlp.nix
    ../../modules/nixos/virt-manager.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # CLI driver
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # For newer
      # intel-compute-runtime
      # For older Intel CPU's
      intel-media-driver
      intel-compute-runtime-legacy1
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

  # For network support in file manager
  services.gvfs.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Default user";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs user;};
    useUserPackages = true;
    backupFileExtension = "backup";
    backupCommand = "rm";
    users = {
      ${user} = import ./home.nix;
    };
  };

  # Install Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    udiskie # Disk manager
    lm_sensors # Temperature sensors
    brightnessctl # Brightness control
    zoxide # Moving in terminal

    # Deleting all .backup files
    (pkgs.writeShellScriptBin "clean-backups" ''
      echo "Deleting ol' backup files..."
      find "$HOME" -type f -name '*.backup' -delete
      echo "Done!"
    '')

    # Get all .desktop files installed
    (pkgs.writeShellScriptBin "get-all-apps" ''
      ls /etc/profiles/per-user/matthew/share/applications
      ls /run/current-system/sw/share/applications
    '')
  ];

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      customFont # Custom font
      jetbrains-mono # System font
      noto-fonts # Noto fonts
      font-awesome # Icon font
      nerd-fonts.jetbrains-mono # Nerd font
    ];
  };

  # Ly
  services.displayManager.ly.enable = true;

  # List services that you want to enable:
  services.udisks2.enable = true;

  # VPN service
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # GUI for Hamachi
  # programs.haguichi.enable = true;

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
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/";
    dates = "daily";
  };

  # Never change that
  system.stateVersion = "25.05";
}
