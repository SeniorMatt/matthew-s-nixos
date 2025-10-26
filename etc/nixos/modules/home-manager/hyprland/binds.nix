{
  wayland.windowManager.hyprland.settings = {
    # Variables
    "$terminal" = "kitty";
    "$fileManager" = "nautilus";
    "$dmenu" = "tofi-drun | xargs hyprctl dispatch exec --";
    "$menu" = "tofi-run -c ~/.config/tofi/config-run | xargs hyprctl dispatch exec --";
    "$kmenu" = "tofi-run -c ~/.config/tofi/config-kill | xargs pkill";
    "$mainMod" = "SUPER";

    bind = [
      # System
      "$mainMod, C, killactive"
      "$mainMod, M, exit"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating"
      "$mainMod, F, fullscreen"
      "$mainMod, P, pseudo"
      "$mainMod, I, togglesplit"

      # Menu
      "$mainMod, SPACE, exec, $dmenu"
      "$mainMod + ALT, SPACE, exec, $menu"
      "$mainMod + CTRL, SPACE, exec, $kmenu"

      # Screenshot
      ", print, exec, hyprshot -m region"
      "SHIFT, print, exec, hyprshot -m output"

      # Notification manager
      # "$mainMod, A, exec, swaync-client -op"

      # Reload bar, wallpaper and notification manager
      # "$mainMod, R, exec, pkill waybar && waybar & pkill hyprpaper && hyprpaper & pkill swaync && swaync"

      # Reload bar and wallpaper 
      "$mainMod, R, exec, pkill waybar && waybar & pkill hyprpaper && hyprpaper"

      # Animations + Blur toggle
      "$mainMod, B, exec, hyprctl keyword animations:enabled 1 && hyprctl keyword decoration:blur:enabled 1"
      "$mainMod + SHIFT, B, exec, hyprctl keyword animations:enabled 0 && hyprctl keyword decoration:blur:enabled 0"

      # Applications
      "$mainMod + SHIFT, C, exec, $terminal"
      "$mainMod + SHIFT, F, exec, firefox"
      "$mainMod + SHIFT, O, exec, obsidian"
      "$mainMod + SHIFT, T, exec, Telegram"

      # Focus with vim keys
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      # Move windows with vim keys
      "$mainMod + SHIFT, H, movewindow, l"
      "$mainMod + SHIFT, L, movewindow, r"
      "$mainMod + SHIFT, K, movewindow, u"
      "$mainMod + SHIFT, J, movewindow, d"

      # Resize windows with vim keys
      #"$mainMod + CTRL, l, resizeactive, -32 0"
      "$mainMod + CTRL, h, resizeactive, -32 0"
      "$mainMod + CTRL, k, resizeactive, 0 -32"
      #"$mainMod + CTRL, j, resizeactive, 0 -32"

      "$mainMod + CTRL, l, resizeactive, 32 0"
      #"$mainMod + CTRL, h, resizeactive, 32 0"
      #"$mainMod + CTRL, k, resizeactive, 0 32"
      "$mainMod + CTRL, j, resizeactive, 0 32"

      # Switch workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move to workspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Special workspace
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through workspaces
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
    ];

    # Move/resize windows with mouse
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Media and brightness keys
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
