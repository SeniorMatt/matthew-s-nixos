{pkgs, ...}: {
  home.packages = with pkgs; [
    kitty
  ];

  xdg.configFile = {
    "kitty/kitty.conf".text = ''
      background_opacity 0.9
      confirm_os_window_close 0
      font_size 13
      font_family JetBrains Mono
    '';
  };
}
