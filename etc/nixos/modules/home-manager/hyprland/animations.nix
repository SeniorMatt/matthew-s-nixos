let
  time = "5";
in {
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = "yes";
      bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
      animation = [
        "windows, 1, ${time}, myBezier, slide"
        "windowsOut, 1, ${time}, myBezier, gnomed"
        "layersIn, 1, ${time}, myBezier, slide top"
        "layersOut, 1, ${time}, myBezier, slide bottom"
        "fade, 1, ${time}, myBezier"
        "workspaces, 1, ${time}, myBezier, slide"
        "specialWorkspaceIn, 1, ${time}, myBezier, slide bottom"
        "specialWorkspaceOut, 1, ${time}, myBezier, slide top"
      ];
    };
  };
}
