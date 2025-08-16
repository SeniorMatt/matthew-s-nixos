{
  config,
  pkgs,
  inputs,
  ...
}: let
  breeze-cursors-catppuccin = inputs.breeze-cursors-catppuccin.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs; [
    adwaita-icon-theme
    breeze-cursors-catppuccin
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
      name = "Breeze_Catppuccin";
      package = breeze-cursors-catppuccin;
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

  home.file.".icons/default".source = "${breeze-cursors-catppuccin}/share/icons/Breeze_Catppuccin";

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kvantum";
    QT_STYLE_OVERRIDE = "kvantum";
    XCURSOR_THEME = "Breeze_Catppuccin";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Breeze_Catppuccin";
    HYPRCURSOR_SIZE = "24";
  };
}
