{
  pkgs,
  config,
  lib,
  ...
}: 
{
  options.tofi = with lib; {
    enable = mkEnableOption "Enable tofi";
    cornerRadius = mkOption {
      type = types.str;
      default = "8";
    };
  };

  config = with config.tofi; lib.mkIf enable {
    home.packages = with pkgs; [tofi];
    xdg.configFile = {
      "tofi/config".text = ''
        font-size = 22
        width = 32%
        height = 48%
        border-width = 8
        corner-radius = ${cornerRadius}
        outline-width = 0
        result-spacing = 0
        num-results = 11
        font = JetBrains Mono
        prompt-text = "[drun]: "
      '';
      "tofi/config-run".text = ''
        font-size = 22
        width = 32%
        height = 64%
        border-width = 8
        corner-radius = ${cornerRadius}
        outline-width = 0
        result-spacing = 0
        num-results = 16
        font = JetBrains Mono
        prompt-text = "[run]: "
      '';
      "tofi/config-kill".text = ''
        font-size = 22
        width = 32%
        height = 32%
        border-width = 8
        corner-radius = ${cornerRadius}
        outline-width = 0
        result-spacing = 0
        num-results = 7
        font = JetBrains Mono
        prompt-text = "[kill]: "
      '';
    };
  };
}
