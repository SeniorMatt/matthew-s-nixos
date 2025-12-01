{ lib, config, ... }:
{
  config = lib.mkIf (config.kitty.theme == "matugen") {
    programs.kitty = {
      settings = {
        include = "./kitty-colors.conf";
      };
    };
  };
}
