{ pkgs, ... }:
{
  import = [ 
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
