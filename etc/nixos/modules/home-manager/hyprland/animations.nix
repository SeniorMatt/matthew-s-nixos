{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = "yes";
      bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
      animation = [
        "windows, 1, 3, myBezier"
        "windowsOut, 1, 4, myBezier, popin 80%"
        "fade, 1, 2, myBezier"
        "workspaces, 1, 2, myBezier, fade"
      ];
    };
  };
}
