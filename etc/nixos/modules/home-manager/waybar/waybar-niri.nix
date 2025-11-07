{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "bottom";
        spacing = 8;

        modules-left = [ "custom/distrologo" "niri/workspaces" "niri/language" ];
        modules-center = [ "niri/window" ];
        modules-right = [ "tray" "battery" "battery#bat1" "pulseaudio" "clock" "custom/power" ];

        "niri/workspaces" = {
          format = "[{name}]";
          format-icons = {
            urgent = "[!]";
            focused = "[]";
            default = "[]";
          };
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 ];
          };
        };
        "niri/language" = {
          format = "[{short}]";
        };
        tray = {
          icon-size = 20;
          spacing = 2;
        };
        clock = {
          format = "[{:%H:%M}]";
          format-alt = "[{:%Y-%m-%d}]";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        cpu = {
          format = "[ {usage}%]";
          tooltip = false;
        };
        memory = {
          format = "[ {}%]";
        };
        temperature = {
          thermal-zone = 5;
          critical-threshold = 80;
          format-critical = "{temperatureC}°C {hot}";
          format-icons = [ "" ];
          format = "[{icon} {temperatureC}°C]";
        };
        battery = {
          bat = "BAT0";
          states = {
            good = 85;
            warning = 30;
            critical = 15;
          };
          format = "[{capacity}% {icon}]";
          format-full = "[{capacity}% {icon}]";
          format-charging = "[{capacity}% ]";
          format-plugged = "[{capacity}% ]";
          format-icons = [ "" "" "" "" "" ];
        };
        "battery#bat1" = {
          bat = "BAT1";
          states = {
            good = 85;
            warning = 30;
            critical = 15;
          };
          format = "[{capacity}% {icon}]";
          format-full = "[{capacity}% {icon}]";
          format-charging = "[{capacity}% ]";
          format-plugged = "[{capacity}% ]";
          format-icons = [ "" "" "" "" "" ];
        };
        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        pulseaudio = {
          scroll-step = 2.5;
          format = "[{icon} {volume}%]";
          format-bluetooth = "{volume}% {icon} ";
          format-bluetooth-muted = " {icon} ";
          format-muted = " Muted";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          format = "[⏻]";
          tooltip = true;
          tooltip-format = "Suspend system";
          on-click = "systemctl suspend";
        };
        "custom/wifi" = {
          format = "";
          tooltip = false;
          on-click = "nm-connection-editor";
        };
        "custom/bluetooth" = {
          format = "";
          tooltip = false;
          on-click = "blueberry";
        };
        "custom/distrologo" = {
          format = "[{icon}]";
          tooltip-format = "I'm using NixOS BTW";
          tooltip = true;
          format-icons = {
            default = "";
          };
          on-click = "rofi -modi drun,calc,emoji,run -show drun -no-persist-history";
        };
      }
    ];
  };
}
