{ pkgs, lib, config, ... }:
let
  frame    = "#89b4fa";
  bg       = "#1e1e2e";
  fg       = "#cdd6f4";
  critical = "#fab387";
in {
  options.dunst = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "8";
    };
  };

  config = with config.dunst; {
    home.packages = with pkgs; [ libnotify dunst ];
    xdg.configFile."dunst/dunstrc" = {
      text = ''
        [global]
        frame_color = "${frame}"
        separator_color = frame
        highlight = "${frame}"
        corner_radius = "${cornerRadius}"
        font = "JetBrains Mono 12"

        [urgency_low]
        background = "${bg}"
        foreground = "${fg}"

        [urgency_normal]
        background = "${bg}"
        foreground = "${fg}"

        [urgency_critical]
        background = "${bg}"
        foreground = "${fg}"
        frame_color = "${critical}"
      '';
    };
  };
}
