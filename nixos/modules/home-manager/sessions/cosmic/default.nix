{ pkgs, ... }:
{
  imports = [ 
    ../../theming
  ];
  
  home.packages = with pkgs; [
    eog # Image viewer
    cosmic-ext-tweaks # Tweaking tool for COSMIC
  ];

  theme = {
    enable = false; # Enabling default GTK and QT theming
    gtk = {
      enable = false;
    };
    cursor = { # Changing cursor to the preferred one
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
  };
}
