{
  wayland.windowManager.hyprland.settings = {
    gesture = [
      # To have 1:1 gestures
      # "3, horizontal, scale: 0.5, workspace"
      # "3, vertical, scale: 0.5, special, magic"
      "3, left, scale: 3.0, dispatcher, workspace, e+1"
      "3, right, scale: 4.0, dispatcher, workspace, e-1"
      "3, vertical, dispatcher, togglespecialworkspace, magic"
      "3, pinch, fullscreen"
      "4, pinchout, close"
    ];
  };
}
