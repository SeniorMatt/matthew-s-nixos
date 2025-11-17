{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };
}
