{
  pkgs,
  config,
  ...
}: let
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/catppuccin/puffy-stars.jpg";
  cornerRadius = "10";
in {
  imports = [
    ../theme.nix

    ./tofi.nix # App launcher
    ./waybar.nix # Panel
    ./swayncenter.nix # Notification manager
  ];

  theme = {
    enable = true;

    # Font
    fontSize = 12;
    fontFamily = "Noto Sans";
    
    # Icons
    iconName = "Adwaita";
    iconTheme = pkgs.adwaita-icon-theme;

    # Cursor
    cursorName = "breeze_cursors";
    cursorTheme = pkgs.kdePackages.breeze;
    cursorSize = 24;

    # GTK
    gtkEnable = true;
    gtkName = "catppuccin-mocha-lavender-standard+normal";
    gtkTheme = pkgs.catppuccin-gtk.override {
      accents = ["lavender"];
      size = "standard";
      variant = "mocha";
      tweaks = ["normal"];
    };

    # Kvantum
    kvantumEnable = true;
    kvantumName = "catppuccin-mocha-lavender";
    kvantumTheme = pkgs.catppuccin-kvantum.override {
      accent = "lavender";
      variant = "mocha";
    };
  };

  programs = {
    tofi = {
      #inherit cornerRadius;
      enable = true;
    };

    waybar = {
      inherit cornerRadius;
      enable = true;
    };

    swayncenter = {
      inherit cornerRadius;
      enable = true;
    };
  };

  home.packages = with pkgs; [
    # System applications
    wlsunset # Blue light filter
    hyprpaper # Wallpaper
    hyprpolkitagent # Authentification agent
    hyprshot # Screenshot utility
    swayosd # Notifications for the volume and brightness
    yazi # TUI File manager

    # Gnome
    nautilus # File manager
    eog # Image viewer
    papers # Document viewer

    # Players
    mpv # Media player

    kdePackages.kcalc # Calculator

    # Controls
    batmon # TUI battery
    btop # TUI task manager
    blueman # Bluetooth control
    networkmanagerapplet # Network control
    pavucontrol # Audio control

    # Needs
    unzip # Unzip
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "application/pdf" = "org.gnome.Papers.desktop";
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

  # Session variables
  home.sessionVariables = {
    XDG_PICTURES_DIR = "$HOME/Pictures";
    HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Auto-start for services
    xwayland.enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      # Hyprland plugins
      # hyprbars
    ];

    settings = {
      # Variables
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$dmenu" = "tofi-drun | xargs hyprctl dispatch exec --";
      "$menu" = "tofi-run -c ~/.config/tofi/config-run | xargs hyprctl dispatch exec --";
      "$kmenu" = "tofi-run -c ~/.config/tofi/config-kill | xargs pkill";
      "$mainMod" = "SUPER";

      # Keybinds
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
        "$mainMod, A, exec, swaync-client -op"

        # Reload bar and wallpaper
        "$mainMod, R, exec, pkill waybar && waybar & pkill hyprpaper && hyprpaper & pkill swaync && swaync"

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
        "$mainMod + CTRL, H, movewindow, l"
        "$mainMod + CTRL, L, movewindow, r"
        "$mainMod + CTRL, K, movewindow, u"
        "$mainMod + CTRL, J, movewindow, d"

        # Resize windows with vim keys
        "$mainMod SHIFT, l, resizeactive, 32 0"
        "$mainMod SHIFT, h, resizeactive, -32 0"
        "$mainMod SHIFT, k, resizeactive, 0 -32"
        "$mainMod SHIFT, j, resizeactive, 0 32"

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
        "swaync"
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
          name = "tpps/2-elan-trackpoint";
          accel_profile = "flat";
          sensitivity = 0.0;
          scroll_factor = 0.25;
        }
      ];

      # Look & Feel
      general = {
        gaps_in = 5; # 5
        gaps_out = 20; # 20
        border_size = 2;
        "col.active_border" = "rgb(b4befe)";
        # "col.inactive_border" = "rgb(313244)";
        "col.inactive_border" = "rgb(6c7086)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = "${cornerRadius}";
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 3;
          render_power = 3;
          sharp = false;
          color = "rgba(0, 0, 0, 1)";
          offset = "0 0";
        };

        blur = {
          enabled = true;
          size = 3; # Default - 3
          passes = 1; # Will increase GPU usage, default - 1
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

        # Smart gaps
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      # Rules
      windowrule = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:0,fullscreen:0,pinned:0"

        # Smart gaps
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

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

      # Waybar blur rules
      layerrule = [
        "blur, waybar"
        "ignorealpha, waybar"
      ];

      # Animations
      animations = {
        enabled = "yes";
        bezier = ["myBezier, 0.05, 0.9, 0.1, 1.1"];
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 1.5, myBezier, popin 80%"
          "fade, 1, 2, myBezier"
          "workspaces, 1, 2, default"
        ];
      };

      plugin = {
        #hyprbars = {
        # bar_height = 16;
        # bar_color = "rgba(181825ee)";
        # col.text = "rgb(cdd6f4)";
        # bar_text_size = 10;
        # bar_text_font = "JetBrainsMono Nerd Font Mono Bold";
        # bar_button_padding = 12;
        # bar_padding = 10;
        # bar_precedence_over_border = true;

        # "hyprbars-button" = [
        # "rgb(f38ba8), 20, , hyprctl dispatch killactive"
        # "rgb(a6e3a1), 20, , hyprctl dispatch fullscreen 2"
        # "rgb(f9e2af), 20, , hyprctl dispatch togglefloating"
        #];
        #};
      };
    };
  };
}
