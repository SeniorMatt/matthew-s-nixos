{pkgs, ...}: let
  corner-radius = "8";
in {
  home.packages = with pkgs; [
    tofi
  ];

  xdg.configFile = {
    "tofi/config".text = ''
      width = 32%
      height = 48%
      border-width = 8
      corner-radius = ${corner-radius}
      outline-width = 0
      result-spacing = 10
      num-results = 8
      font = JetBrains Mono
      prompt-text = "Launch: "

      background-color = #1e1e2e
      border-color = #cba6f7
      selection-color = #cba6f7
      text-color = #74c7ec
    '';
    "tofi/config-run".text = ''
      width = 32%
      height = 48%
      border-width = 8
      corner-radius = ${corner-radius}
      outline-width = 0
      result-spacing = 10
      num-results = 8
      font = JetBrains Mono
      prompt-text = "Start: "

      background-color = #1e1e2e
      border-color = #a6e3a1
      selection-color = #a6e3a1
      text-color = #74c7ec
    '';
    "tofi/config-kill".text = ''
      width = 32%
      height = 48%
      border-width = 8
      corner-radius = ${corner-radius}
      outline-width = 0
      result-spacing = 10
      num-results = 8
      font = JetBrains Mono
      prompt-text = "Kill: "

      background-color = #1e1e2e
      border-color = #f38ba8
      selection-color = #f38ba8
      text-color = #f9e2af
    '';
  };
}
