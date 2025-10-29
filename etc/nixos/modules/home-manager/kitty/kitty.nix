{pkgs, ...}: {
  home.packages = with pkgs; [
    kitty
  ];

  xdg.configFile = {
    "kitty/kitty.conf".text = ''
      confirm_os_window_close 0
      remember_window_size no
      initial_window_width 94 c
      initial_window_height 22 c
      font_size 13
      font_family JetBrains Mono
    '';
  };
}
