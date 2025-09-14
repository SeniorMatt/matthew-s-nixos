{pkgs, ...}: {
  home.packages = with pkgs; [
    xfce.thunar
  ];

  xdg.configFile = {
    "gtk-3.0/bookmarks".text = ''
      file:///home/matthew/Downloads Downloads
      file:///home/matthew/Documents Documents
      file:///home/matthew/Documents/GitHub GitHub
      file:///home/matthew/Pictures Pictures
      file:///home/matthew/Videos Videos
      file:///home/matthew/.local/share/Trash Trash
    '';
  };
}
