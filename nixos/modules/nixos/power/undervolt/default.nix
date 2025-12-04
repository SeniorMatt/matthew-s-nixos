{
  services.undervolt = {
    enable = true;
    turbo = 1; # 1

    # All values are in millivolts (mV), negative = undervolt.
    coreOffset = -125;
    gpuOffset = -125;

    uncoreOffset = 0;
    analogioOffset = 0;

    temp = 90; # global target
    tempAc = 90; # on AC
    tempBat = 90; # on battery
  };
}
