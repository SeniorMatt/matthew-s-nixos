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

        background-color = #1e1e2e
        border-color = #cba6f7
        selection-color = #cba6f7
        text-color = #74c7ec
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

        background-color = #1e1e2e
        border-color = #a6e3a1
        selection-color = #a6e3a1
        text-color = #74c7ec
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

        background-color = #1e1e2e
        border-color = #f38ba8
        selection-color = #f38ba8
        text-color = #f9e2af
      '';
    };
  };
}
