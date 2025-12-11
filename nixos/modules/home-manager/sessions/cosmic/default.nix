{ pkgs, repoPath, config, ... }:
{
  imports = [ 
    ../../theming
  ];
  
  home.packages = with pkgs; [
    eog # Image viewer
    gnome-calendar # Calendar
    cosmic-ext-tweaks # Tweaking tool for COSMIC
  ];

  home.file.".config/cosmic" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/.config/cosmic";
    recursive = true;
  };

  theme = {
    enable = true; # Enabling default GTK and QT theming
    gtk = {
      enable = false;
    };
    qt = {
      enable = true;
    };
    cursor = { # Changing cursor to the preferred one
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
  };
}
