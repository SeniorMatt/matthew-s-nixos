{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Ignore maximize requests from apps. You'll probably like this.
      "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:0,fullscreen:0,pinned:0"

      # Smart gaps
      # "bordersize 0, floating:0, onworkspace:w[tv1]"
      # "rounding 0, floating:0, onworkspace:w[tv1]"
      # "bordersize 0, floating:0, onworkspace:f[1]"
      # "rounding 0, floating:0, onworkspace:f[1]"

      # Firefox PiP
      "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
      "pin, class:^(firefox)$, title:^(Picture-in-Picture)$"

      # Opacity for specific windows
      # "opacity 0.85 0.85, class: org.kde.dolphin"
      # "opacity 0.85 0.85, title:^(Volume Control)$"
      # "opacity 0.85 0.85, class: .blueman-manager-wrapped"

      # XWayland video bridge
      "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      "noanim, class:^(xwaylandvideobridge)$"
      "noinitialfocus, class:^(xwaylandvideobridge)$"
      "maxsize 1 1, class:^(xwaylandvideobridge)$"
      "noblur, class:^(xwaylandvideobridge)$"
      "nofocus, class:^(xwaylandvideobridge)$"
    ];

    layerrule = [
      # "animation styleOfAnimation, name"
      "blur, waybar"
      "ignorealpha, waybar"
      "noanim, hyprpicker"
      "noanim, selection"
    ];
  };
}
