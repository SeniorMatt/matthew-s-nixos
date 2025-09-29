{
  pkgs,
  config,
  ...
}: let
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/catppuccin/pompeii.png";
in {
  imports = [
    ./theme-catppuccin.nix # GTK, QT and Cursor themes
    ./tofi.nix # App launcher
    ./waybar.nix # Panel
    ./dunst.nix # Notification manager
  ];

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    swayosd # Notifications for the volume and brightness
    wl-clipboard # Clipboard manager
    yazi # TUI File manager

    # KDE
    kdePackages.dolphin
    kdePackages.kate

    # Players
    mpv # Media player
    kdePackages.gwenview # Image viewer
    kdePackages.okular # Document viewer

    # Controls
    batmon # TUI battery
    btop # TUI task manager
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    lxqt.pavucontrol-qt # Audio control

    # Needs
    grim # Screenshot
    slurp # Selector for screenshot
    unzip # Unzip
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "application/pdf" = "org.kde.okular.desktop";
    };
  };

  xdg.configFile = {
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

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Auto-start for services
    xwayland.enable = true;

    settings = {
      # Variables
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$dmenu" = "tofi-drun | xargs hyprctl dispatch exec --";
      "$menu" = "tofi-run | xargs hyprctl dispatch exec --";
      "$mainMod" = "SUPER";

      # Keybinds
      bind = [
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "ALT, SPACE, exec, $dmenu"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, F, fullscreen"
        "$mainMod, P, pseudo"
        "$mainMod, I, togglesplit"

        ", print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, print, exec, grim - | wl-copy"

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

        # Move windows with Ctrl+vim keys
        "$mainMod + CONTROL, H, movewindow, l"
        "$mainMod + CONTROL, L, movewindow, r"
        "$mainMod + CONTROL, K, movewindow, u"
        "$mainMod + CONTROL, J, movewindow, d"

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

      # Autostart
      "exec-once" = [
        "hyprpaper"
        "waybar"
        "dunst"
        "nm-applet"
        "blueman-applet"
        "wlsunset -l 43.2 -L 76.9"
        "udiskie"
        "swayosd-server"
        "swayosd-libinput-backend"
      ];

      # Input
      input = {
        kb_layout = "us, ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:caps_toggle";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "adaptive";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      # Per-device settings
      device = [
        {
          name = "compx-2.4g-dual-mode-mouse";
          accel_profile = "flat";
          sensitivity = -0.25;
        }
        {
          name = "compx-2.4g-wireless-receiver";
          accel_profile = "flat";
          sensitivity = -0.25;
        }
        {
          name = "tpps/2-ibm-trackpoint";
          accel_profile = "flat";
          sensitivity = 0.25;
        }
      ];

      # Look & Feel
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 4;
        "col.active_border" = "rgb(b4befe)";
        "col.inactive_border" = "rgb(1e1e2e)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 12;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 6;
          render_power = 3;
          color = "rgba(1e1e2eee)";
        };

        blur = {
          enabled = true;
          size = 6; # Default - 3
          passes = 2; # Increasing this setting will increase GPU usage, default - 1
          vibrancy = 0.1696;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # scRGB support
      debug.full_cm_proto = true;

      # Monitors
      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1.0"
        "HDMI-A-2, 2560x1440@75, 0x-1440, 1.0"
      ];

      # Default workspaces (and pin some to HDMI-A-2)
      workspace = [
        "4, monitor:HDMI-A-2"
        "5, monitor:HDMI-A-2"
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
      ];

      # Rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:0,fullscreen:0,pinned:0"

        # Firefox PiP
        "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
        "pin, class:^(firefox)$, title:^(Picture-in-Picture)$"

        # Opacity for specific windows
        "opacity 0.85 0.85, class: org.kde.dolphin"
        "opacity 0.85 0.85, title:^(Volume Control)$"
        "opacity 0.85 0.85, class: .blueman-manager-wrapped"

        # XWayland video bridge
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      # Waybar blur rules
      layerrule = [
        "blur, waybar"
        "ignorealpha, waybar"
      ];

      # Animations
      animations = {
        enabled = "yes";
        bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, myBezier, popin 80%"
          "fade, 1, 5, default"
          "workspaces, 1, 3, default"
        ];
      };
    };
  };
}
