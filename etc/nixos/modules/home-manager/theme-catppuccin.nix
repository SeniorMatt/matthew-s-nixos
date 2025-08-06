{
  config,
  pkgs,
  inputs,
  ...
}: let
  cursor-default-theme = pkgs.runCommandLocal "cursor-default-theme" {} ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.catppuccin-cursors}/share/icons/catppuccin-mocha-dark-cursors $out/share/icons/default
  '';
in {
  home.packages = with pkgs; [
    adwaita-icon-theme
    cursor-default-theme
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  catppuccin.flavor = "mocha";
  catppuccin.accent = "lavender";

  catppuccin.starship.enable = true;

  catppuccin.kvantum.enable = true;

  catppuccin.gtk.enable = true;
  catppuccin.gtk.flavor = "mocha";
  catppuccin.gtk.accent = "lavender";
  catppuccin.gtk.tweaks = ["normal"];
  catppuccin.gtk.size = "compact";

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = ''1 '';
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = ''1 '';
    };
  };

  #dconf.settings = {
  #"org/gnome/desktop/wm/preferences" = {
  #button-layout = ":close";
  #};
  #};

  home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors";

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kvantum";
    QT_STYLE_OVERRIDE = "kvantum";
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    HYPRCURSOR_SIZE = "24";
  };
}
