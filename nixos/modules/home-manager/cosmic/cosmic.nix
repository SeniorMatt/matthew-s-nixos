{ pkgs, ... }:
{
  imports = [ 
    ../theme.nix
  ];
  theme = {
    enable = true;
    cursor = {
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
  };
}
