{ pkgs, user, repoPath, inputs, ... }: let
  customFont = pkgs.callPackage ../../modules/nixos/fonts {};
  older-pkgs = import inputs.nixpkgs-c5ae371f1 {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/nixos/system/bluetooth
    ../../modules/nixos/system/audio
    # ../../modules/nixos/power/tuned
    # ../../modules/nixos/power/system76
    # ../../modules/nixos/power/power-profiles-daemon
    ../../modules/nixos/power/tlp
  ] ;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # OpenCL & VA-API & Vulkan drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      older-pkgs.intel-compute-runtime-legacy1
      older-pkgs.intel-media-driver
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

  # Disabling throttling overriting
  services.throttled.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs user repoPath;};
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

  # KDE Partition manager
  programs.partition-manager.enable = true; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
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
      minecraftia # Minecraft font
      monocraft # Mono Minecraft font
      nerd-fonts.jetbrains-mono # Nerd font
    ];
  };

  # VPN service
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

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

  # Auto upgrades
  system.autoUpgrade = {
    enable = true;
    flake = "/home/${user}/Matthew-s-NixOS/nixos/";
    dates = "daily";
  };

  # Never change that
  system.stateVersion = "25.05";
}
