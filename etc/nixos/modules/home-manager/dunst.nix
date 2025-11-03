{ pkgs, lib, config, ... }:
let
  frame = "#89b4fa";
  bg = "#1e1e2e";
  fg = "#cdd6f4";
in {
  options.dunst = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "8";
    };
  };

  config = with config.dunst; {
    home.packages = with pkgs; [ libnotify ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          frame_color = "${frame}";
          separator_color = "frame";
          highlight = "${frame}";
          corner_radius = "${cornerRadius}";
          font = "JetBrains Mono 13";
        };
        urgency_normal = {
          background = "${bg}";
          foreground = "${fg}";
          timeout = 3;
        };
      };
    };
  };
}
