{ lib, config, ... }:
{
  config = lib.mkIf (config.kitty.theme == "catppuccin") {
    programs.kitty = {
      themeFile = "Catppuccin-Mocha";
    };
  };
}
