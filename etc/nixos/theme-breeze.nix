{ config, pkgs, inputs, ... }:

let
  cursor-default-theme = pkgs.runCommandLocal "cursor-default-theme" { } ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
    '';
in
{
  home.packages = with pkgs; [
    cursor-default-theme
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "breeze";
    style.name = "breeze";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-icons;
    };

    cursorTheme = {
      name = "breeze_cursors";
      #package = pkgs.kdePackages.breeze;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":close";
    };
  };

    home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
  };

}
