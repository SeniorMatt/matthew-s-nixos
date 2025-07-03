{ config, pkgs, inputs, ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    fonts = {
      general = {
	family = "Noto Sans";
        pointSize = 12;
      };
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Breeze Dark";
        size = 24;
      };
    };

    shortcuts = {
      kwin = {
        "Close Window" = "Meta+C";
      };
    };

    hotkeys.commands."launch-kitty" = {
      name = "Launch Kitty";
      key = "Meta+Shift+C";
      command = "kitty";
    };
  };
}
