{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "power_save";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      #CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power_save";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      #Fix low FPS/stutter/FPS drops on Intel iGPU
      INTEL_GPU_MIN_FREQ_ON_AC = 500;
      INTEL_GPU_MIN_FREQ_ON_BAT = 500;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 85; # 85 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 90; # 90 and above it stops charging
    };
  };
}
