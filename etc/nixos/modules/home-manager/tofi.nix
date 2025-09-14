{pkgs, ...}: {
  home.packages = with pkgs; [
    tofi
  ];

  xdg.configFile = {
    "tofi/config".text = ''
      width = 36%
      height = 48px
      border-width = 4
      corner-radius = 8
      outline-width = 0
      result-spacing = 10
      num-results = 12
      font = JetBrains Mono

      background-color = 181825
      border-color = #94e2d5
      selection-color = #cba6f7
      text-color = #cdd6f4
    '';
  };
}
