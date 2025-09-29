{pkgs, ...}: {
  home.packages = with pkgs; [
    tofi
  ];

  xdg.configFile = {
    "tofi/config".text = ''
      width = 28%
      height = 48%
      border-width = 4
      corner-radius = 8
      outline-width = 0
      result-spacing = 10
      num-results = 8
      font = JetBrains Mono

      background-color = 181825
      border-color = #89b4fa
      selection-color = #f38ba8
      text-color = #cdd6f4
    '';
  };
}
