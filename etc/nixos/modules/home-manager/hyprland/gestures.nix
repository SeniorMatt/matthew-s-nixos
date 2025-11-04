{
  wayland.windowManager.hyprland.settings = {
    gesture = [
      # To have not 1:1 gestures
      # "3, left, scale: 3.0, dispatcher, workspace, +1"
      # "3, right, scale: 4.0, dispatcher, workspace, -1"
      # "3, vertical, dispatcher, togglespecialworkspace, magic"
      "3, horizontal, scale: 1.0, workspace"
      "3, vertical, scale: 1.0, special, magic"
      "3, pinch, dispatcher, fullscreen"
      "4, pinchout, dispatcher, killactive"
      "4, pinchin, dispatcher, execr, rofi -show"
    ];
  };
}
