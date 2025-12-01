{ lib, ... }:
{
  options.kitty = with lib; {
    theme = mkOption {
      type = types.enum [ "none" "catppuccin" "matugen" "medallion" ];
      default = "none";
      description = "Choose kitty's theme";
    };
  };
  
  config.programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 13;
    };
    settings = {
      background_opacity = 1;
      confirm_os_window_close = 0;
      remember_window_size = "no";
      initial_window_width = "94 c";
      initial_window_height = "22 c";
    };
  };
}
