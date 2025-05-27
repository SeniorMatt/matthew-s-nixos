# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matthew = {
    isNormalUser = true;
    description = "Matthew";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "matthew" = import ./home.nix;
      };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     gcc
     ffmpeg

     hyprland                 # WM
     ly                       # Login manager
     wl-clipboard             # Clipboard
     power-profiles-daemon    # Power profiles daemon
     brightnessctl            # Brightness control
     dunst                    # Notifications daemon
     hyprpolkitagent          # Authenetication daemon
     gnome-keyring            # Keyring daemon
     zoxide                   # Moving in terminal
  ];

  fonts.packages = with pkgs; [
     jetbrains-mono           # System font
     font-awesome             # Icon font
     nerd-fonts.symbols-only  # Nerd font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copying configuration files in to my GitHub repo
  system.activationScripts.mySyncScript = {
    text = ''
      #!/bin/sh
      
      echo "Copying NixOS configuration..."
      cp -r /etc/nixos/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/etc/
      rm -f /home/matthew/Documents/GitHub/Matthew-s-NixOS/etc/nixos/hardware-configuration.nix

      echo "Copying Dotfiles..."
      cp -r /home/matthew/.config/dunst/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/hypr/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/kitty/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/nvim/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/tofi/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/waybar/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/waypaper/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
      cp -r /home/matthew/.config/wlogout/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
