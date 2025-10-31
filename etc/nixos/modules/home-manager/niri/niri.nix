{pkgs, inputs, config, ...}:
let
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/Straßenszene\ bei\ Regen,\ Berlin\ \(1926\).jpg";
in {
  imports = [
    inputs.niri-flake.homeModules.niri
    ../theme.nix
    ../kitty/kitty.nix
    ../waybar/waybar-minimal.nix
    ../rofi/rofi.nix
    ../rofi/rofi-minimal-theme.nix
    ../default-apps.nix
  ];

  theme = {
    enable = true;
    fontFamily = "JetBrains Mono";
    fontSize = 13;
    cursorName = "Bibata-Modern-Classic";
    cursorTheme = pkgs.bibata-cursors;
    cursorSize = 24;
  };

  services.polkit-gnome.enable = true; # Polkit
  services.mako = {
    enable = true; # Notification daemon
    settings = {
      font = "JetBrains Mono 13";
      default-timeout = 2500;
    };
  };
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.swayidle.enable = true; # Idle management daemon
  home.packages = with pkgs; [
    swaybg # Wallpaper
    pavucontrol # Audio control
    blueman # Bluetooth control
    wlsunset # Blue light filter
    xwayland-satellite # Xwayland support
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      outputs = {
        "eDP-1" = {
          scale = 1.0;
        };
      };

      hotkey-overlay.skip-at-startup = true;

      input = {
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        keyboard = {
          xkb = {
            layout = "us, ru";
            options = "grp:caps_toggle";
          };
        };
        trackpoint = {
          accel-profile = "flat";
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
      };

      spawn-at-startup = [
        { argv = ["swaybg" "--image" "${wallpaper}"]; }
        { argv = ["wlsunset" "-l" "43.2" "-L" "76.9"]; }
        { argv = ["waybar"]; }
      ];

      prefer-no-csd = true;
      layout = {
        gaps = 4;
        focus-ring = {
          width = 2;
          active.color = "#ffbb51";
        };
      };

      window-rules = [
        {
          matches = [{
            app-id = "firefox$"; 
            title  = "^Picture-in-Picture$";
          }];

          open-floating = true;
        }
      ];
      binds = {
        "Mod+Shift+C".action.spawn = "kitty";
        "Mod+Shift+F".action.spawn = "firefox";
        "Mod+Shift+T".action.spawn = "Telegram";
        "Mod+Shift+O".action.spawn = "obsidian";
        "Mod+D".action.spawn-sh = "rofi modes drun,calc,emoji,run -show drun -no-persist-history";
        "Mod+E".action.spawn = "nautilus";
        "Mod+Alt+L".action.spawn = "swaylock";
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];

        "Mod+C".action.close-window = [];
        "Mod+O".action.toggle-overview = [];

        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];

        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+Shift+L".action.move-column-right = [];

        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        "Mod+Ctrl+H".action.focus-monitor-left = [];
        "Mod+Ctrl+J".action.focus-monitor-down = [];
        "Mod+Ctrl+K".action.focus-monitor-up = [];
        "Mod+Ctrl+L".action.focus-monitor-right = [];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];
        "Mod+Shift+U".action.move-workspace-down = [];
        "Mod+Shift+I".action.move-workspace-up = [];

        "Mod+1".action.focus-workspace = [1];
        "Mod+2".action.focus-workspace = [2];
        "Mod+3".action.focus-workspace = [3];
        "Mod+4".action.focus-workspace = [4];
        "Mod+5".action.focus-workspace = [5];
        "Mod+Shift+1".action.move-column-to-workspace = [1];
        "Mod+Shift+2".action.move-column-to-workspace = [2];
        "Mod+Shift+3".action.move-column-to-workspace = [3];
        "Mod+Shift+4".action.move-column-to-workspace = [4];
        "Mod+Shift+5".action.move-column-to-workspace = [5];

        "Mod+Shift+BracketLeft".action.consume-window-into-column = [];
        "Mod+Shift+BracketRight".action.expel-window-from-column = [];

        "Mod+Comma".action.consume-or-expel-window-left = [];
        "Mod+Period".action.consume-or-expel-window-right = [];

        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];
        "Mod+F".action.maximize-column = [];
        "Mod+M".action.fullscreen-window = [];

        "Mod+Ctrl+F".action.expand-column-to-available-width = [];

        "Mod+Ctrl+C".action.center-column = [];
        "Mod+Shift+Ctrl+C".action.center-visible-columns = [];

        "Mod+Minus".action.set-column-width = ["-10%"];
        "Mod+Equal".action.set-column-width = ["+10%"];

        "Mod+Shift+Minus".action.set-window-height = ["-10%"];
        "Mod+Shift+Equal".action.set-window-height = ["+10%"];

        "Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        "Mod+W".action.toggle-column-tabbed-display = [];

        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = [];

        "Mod+Shift+E".action.quit = [];
        "Ctrl+Alt+Delete".action.quit = [];

        "Mod+Shift+P".action.power-off-monitors = [];

        "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "XF86MonBrightnessUp".action.spawn-sh = "brightnessctl --class=backlight set 10%+";
        "XF86MonBrightnessDown".action.spawn-sh = "brightnessctl --class=backlight set 10%-";
      };
    };
  };
}
