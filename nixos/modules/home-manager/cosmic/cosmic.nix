{ pkgs, ... }:
{
  imports = [ 
    ../theme.nix
    ../kitty/kitty.nix
  ];
  
  home.packages = with pkgs; [
    eog # Image viewer
  ];

  theme = {
    enable = true; # Enabling default GTK and QT theming
    gtk = {
      enable = false;
    };
    cursor = { # Changing cursor to the preferred one
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
  };
}
