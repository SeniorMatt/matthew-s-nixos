{
  pkgs,
  config,
  ...
}: let
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/catppuccin/math.png";
in {
  imports = [
    ./theme-catppuccin.nix # GTK, QT and cursor themes
    ./tofi.nix # App launcher
    ./waybar.nix # Panel
    ./dunst.nix # Notification manager
  ];

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    xdg-desktop-portal-hyprland # Desktop portal hyprland
    swayosd # Notifications for the volume and brightness
    wl-clipboard # Clipboard manager
    yazi # File manager

    # Players
    mpv # Media player
    eog # Image viewer
    papers # Document viewer
    parlatype # Audio player

    # Controls
    batmon # TUI battery
    btop # TUI task manager
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control

    # Needs
    grim # Screenshot
    slurp # Selector for screenshot
    unzip # Unzip
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "xyz.parlatype.Parlatype.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "xyz.parlatype.Parlatype.desktop";
      "application/pdf" = "org.gnome.Papers.desktop";
    };
  };

  xdg.configFile = {
    "hypr/hyprland.conf".text = ''
      # Keybinds
      $terminal = kitty
      $fileManager = $terminal yazi
      $dmenu = tofi-drun | xargs hyprctl dispatch exec --
      $menu = tofi-run | xargs hyprctl dispatch exec --
      $mainMod = SUPER

      # System
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = ALT, SPACE, exec, $dmenu
      bind = $mainMod, SPACE, exec, $menu
      bind = $mainMod, F, fullscreen
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, I, togglesplit, # dwindle

      bind = , print, exec, grim -g "$(slurp)" - | wl-copy
      bind = SHIFT, print, exec, grim - | wl-copy

      # Applications
      bind = $mainMod + SHIFT, C, exec, $terminal
      bind = $mainMod + SHIFT, F, exec, firefox
      bind = $mainMod + SHIFT, O, exec, obsidian
      bind = $mainMod + SHIFT, T, exec, Telegram

      # Move focus with mainMod + vim keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      # Move windwos with mainMod + control + vim keys
      bind = $mainMod + CONTROL, H, movewindow, l
      bind = $mainMod + CONTROL, L, movewindow, r
      bind = $mainMod + CONTROL, K, movewindow, u
      bind = $mainMod + CONTROL, J, movewindow, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Laptop multimedia keys for volume and LCD brightness

      # Volume controls
      bind = ,XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise
      bind = ,XF86AudioLowerVolume, exec, swayosd-client --output-volume lower
      bind = ,XF86AudioMute, exec, swayosd-client --output-volume mute-toggle

      # Mic mute
      bind = ,XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle

      # Brightness controls
      bind = ,XF86MonBrightnessUp, exec, swayosd-client --brightness raise
      bind = ,XF86MonBrightnessDown, exec, swayosd-client --brightness lower

      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # Autostart
      exec-once = hyprpaper & # Wallpaper
      exec-once = waybar & # Waybar
      exec-once = dunst & # Notifications
      exec-once = nm-applet & # Wifi
      exec-once = blueman-applet & # Bluetooth
      exec-once = wlsunset -l 43.2 -L 76.9 # Blue light filter
      exec-once = udiskie & # Manage removable media like flash drives
      exec-once = swayosd-server # For volume bubble
      exec-once = swayosd-libinput-backend

      # Input
      input {
          kb_layout = us, ru
          kb_variant =
          kb_model =
          kb_options = grp:caps_toggle
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          accel_profile = adaptive

          touchpad {
              natural_scroll = true
      	      disable_while_typing = false
          }
      }

      # Mouse
      device {
          name = compx-2.4g-dual-mode-mouse
          accel_profile = flat
          sensitivity = -0.25
      }
      device {
          name = compx-2.4g-wireless-receiver
          accel_profile = flat
          sensitivity = -0.25
      }

      device {
          name = tpps/2-ibm-trackpoint
          accel_profile = flat
          sensitivity = 0.25
      }

      # Look and Feel
      general {
          gaps_in = 4
          gaps_out = 8

          border_size = 3

          # Write 45deg if u want to have animation
          col.active_border = rgb(b4befe)
          col.inactive_border = rgb(1e1e2e)

          resize_on_border = false

          allow_tearing = false

          layout = dwindle
      }

      decoration {
          rounding = 4

          active_opacity = 1.0
          inactive_opacity = 1.0

          shadow {
              enabled = true
              range = 6
              render_power = 3
              color = rgba(1e1e2eee)
          }

          blur {
              enabled = true
              size = 9 # Default value is 3
              passes = 3 # Default value is 1

              vibrancy = 0.1696
      	      new_optimizations = true
      	      ignore_opacity = true
          }
      }

      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
      }

      # Support for scRGB
      debug {
        full_cm_proto = true;
      }

      # Monitors
      monitor = eDP-1, 1920x1080@60, 0x0, 1.0
      monitor = HDMI-A-2, 2560x1440@75, 0x-1440, 1.0

      # Workspaces for second monitor
      workspace = 4, monitor:HDMI-A-2
      workspace = 5, monitor:HDMI-A-2

      # Windows and Workspaces
      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:0,fullscreen:0,pinned:0

      # Waybar blur
      layerrule = blur, waybar
      layerrule = ignorealpha, waybar

      # Rules
      ## Firefox Picture in Picture
      windowrule = float,,class:^(firefox)$,title:^(Picture-in-Picture)$
      windowrule = pin,class:^(firefox)$,title:^(Picture-in-Picture)$

      ## Media & Image player fullscreen
      windowrule = fullscreen,class:^(eog)
      windowrule = fullscreen,class:^(mpv)

      # Workspaces
      workspace = 1, monitor:eDP-1
      workspace = 2, monitor:eDP-1
      workspace = 3, monitor:eDP-1
      workspace = 4, monitor:eDP-1
      workspace = 5, monitor:eDP-1

      # XWayland video bridge
      windowrule = opacity 0.0 override, class:^(xwaylandvideobridge)$
      windowrule = noanim, class:^(xwaylandvideobridge)$
      windowrule = noinitialfocus, class:^(xwaylandvideobridge)$
      windowrule = maxsize 1 1, class:^(xwaylandvideobridge)$
      windowrule = noblur, class:^(xwaylandvideobridge)$
      windowrule = nofocus, class:^(xwaylandvideobridge)$

      # Animations
      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 3, myBezier
          animation = windowsOut, 1, 3, myBezier, popin 80%
          animation = fade, 1, 5, default
          animation = workspaces, 1, 3, default
      }
    '';

    # Hyprpaper
    "hypr/hyprpaper.conf".text = ''
      preload = ${wallpaper}
      wallpaper= , ${wallpaper}
    '';

    # Bookmarks for File Manager
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
