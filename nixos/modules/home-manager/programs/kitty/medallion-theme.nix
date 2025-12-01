{ lib, config, ... }:
{
  config = lib.mkIf (config.kitty.theme == "medallion") {
    programs.kitty = {
      themeFile = "Medallion";
    };
  };
}
