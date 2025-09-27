{
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "always";
      };
    };
  };

  # Disable conflicting services
  services.power-profiles-daemon.enable = false;
}
