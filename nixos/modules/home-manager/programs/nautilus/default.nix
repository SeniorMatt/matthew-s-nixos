{ pkgs, user, ...}:
{
  home.packages = with pkgs; [ nautilus ];
  xdg.configFile = {
    "gtk-3.0/bookmarks".text = ''
      file:///home/${user}/Downloads Downloads
      file:///home/${user}/Documents Documents
      file:///home/${user}/Pictures Pictures
      file:///home/${user}/Pictures/Screenshots Screenshots
      file:///home/${user}/Videos Videos
    '';
  };
}
