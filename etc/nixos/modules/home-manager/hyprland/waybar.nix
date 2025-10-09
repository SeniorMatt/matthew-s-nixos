{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.waybar;
in {
  options.programs.waybar = {
    cornerRadius = lib.mkOption {
      type = lib.types.str;
      default = "8";
      description = "Corner radius";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [waybar];
    xdg.configFile = {
      "waybar/config.jsonc".text = ''
        {
            "layer": "top",
            "position": "top", // top, bottom, left, right
            "margin-left": 0,
            "margin-right": 0,
            "margin-top": 0,
            "spacing": 8,
            "modules-left": [
                "custom/distrologo",
                "hyprland/workspaces",
                "battery",
                "battery#bat1"
            ],
            "modules-center": [
                "keyboard-state",
                "hyprland/language"
            ],
            "modules-right": [
                "tray",
                "custom/notification",
                "pulseaudio",
                "clock",
                "custom/power"
            ],
            // Modules configuration
            "hyprland/workspaces": {
                "all-outputs": true,
                "format": "[{name}]",
                "format-icons": {
                    // "1": "|",
                    "urgent": "[!]",
                    "focused": "[]",
                    "default": "[]"
                },
                "persistent-workspaces": {
                    "*": [ 1,2,3,4,5 ]
                }
            },
            "hyprland/language": {
                "format": "[{short}]"
            },
            "tray": {
                "icon-size": 24,
                "spacing": 2
            },
            "clock": {
                "format": "[{:%H:%M}]",
                "format-alt": "[{:%Y-%m-%d}]",
                "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
            },
            "cpu": {
                "format":  "[ {usage}%]",
                "tooltip": false
            },
            "memory": {
                "format": "[ {}%]"
            },
            "temperature": {
                "thermal-zone": 5,
                "critical-threshold": 80,
                "format-critical": "{temperatureC}°C {hot}",
                "format":  "[{icon} {temperatureC}°C]",
                "format-icons": [""]
            },
            "battery": {
                "bat": "BAT0",
                "states": {
                    "good": 85,
                    "warning": 30,
                    "critical": 15
                },
                "format": "[{capacity}% {icon}]",
                "format-full": "[{capacity}% {icon}]",
                "format-charging": "[{capacity}% ]",
                "format-plugged": "[{capacity}% ]",
                "format-alt": "[{time}]",
                // "format-good": "", // An empty format will hide the module
                // "format-full": "",
                "format-icons": ["", "", "", "", ""]
            },
            "battery#bat1": {
                "bat": "BAT1",
                "states": {
                    "good": 85,
                    "warning": 30,
                    "critical": 15
                },
                "format": "[{capacity}% {icon}]",
                "format-full": "[{capacity}% {icon}]",
                "format-charging": "[{capacity}% ]",
                "format-plugged": "[{capacity}% ]",
                "format-alt": "[{time}]",
                "format-icons": ["", "", "", "", ""]
            },
            "power-profiles-daemon": {
              "format": "{icon}",
              "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
              "tooltip": true,
              "format-icons": {
                "default": "",
                "performance": "",
                "balanced": "",
                "power-saver": ""
              }
            },
            "pulseaudio": {
                "scroll-step": 2.5, // %, can be a float
                //"format": "{volume}% {icon}",
                "format": "[{icon} {volume}%]",
                "format-bluetooth": "{volume}% {icon} ",
                "format-bluetooth-muted": " {icon} ",
                "format-muted": " Muted",
                "format-source": "{volume}% ",
                "format-source-muted": "",
                "format-icons": {
                    "headphone": "",
                    "hands-free": "",
                    "headset": "",
                    "phone": "",
                    "portable": "",
                    "car": "",
                    "default": ["", "", ""]
                },
                "on-click": "pavucontrol"
            },
            "custom/power": {
                "format" : "[⏻]",
                "tooltip": true,
                "tooltip-format": "Suspend system",
                "on-click": "systemctl suspend"
            },
            "custom/wifi": {
                "format" : "",
                "tooltip": false,
                "on-click": "nm-connection-editor"
            },
            "custom/bluetooth": {
                "format" : "",
                "tooltip": false,
                "on-click": "blueberry"
            },
            "custom/distrologo": {
              "format": "[{icon}]",
              "tooltip-format": "I'm using NixOS BTW",
              "tooltip": true,
              "format-icons": {
                "default": ""
              },
              "on-click": "kitty --hold bash -c fastfetch"
            },
            "custom/notification": {
                "tooltip": false,
                "format": "{icon}",
                "format-icons": {
                  "notification": "<span foreground='red'><sup></sup></span>",
                  "none": "",
                  "dnd-notification": "<span foreground='red'><sup></sup></span>",
                  "dnd-none": "",
                  "inhibited-notification": "<span foreground='red'><sup></sup></span>",
                  "inhibited-none": "",
                  "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
                  "dnd-inhibited-none": ""
                },
                "return-type": "json",
                "exec-if": "which swaync-client",
                "exec": "swaync-client -swb",
                "on-click": "swaync-client -t -sw",
                "on-click-right": "swaync-client -d -sw",
                "escape": true
              }
        }
      '';

      "waybar/style.css".text = ''
        * {
            font-family: JetBrainsMono Nerd Font Propo;
            font-size: 12pt;
            transition-duration: .5s;
            transition-property: background-color;
            padding: 0px 4px;
            border-radius: ${cfg.cornerRadius};
        }

        window#waybar {
            background-color: rgba(30, 30, 46, 1);
            border-radius: 0px;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            /* border: none;*/

            margin: 4px 0px;
            padding: 0px 4px;
            color: #cdd6f4;
        }

        #pulseaudio,
        #clock,
        #battery,
        #tray,
        #language,
        #cpu,
        #temperature,
        #custom-power,
        #memory {
            margin: 4px 0px;
            color: #cdd6f4;
            background-color: rgba(49, 50, 68, 1);
            border-radius: ${cfg.cornerRadius};
        }

        #custom-power {
            background-color: #f38ba8;
            color: #11111b;
        }
        #custom-power:hover {
            background-color: #eba0ac;
        }

        #pulseaudio {
            background-color: #cba6f7;
            color: #11111b;
        }
        #pulseaudio:hover {
            background-color: #f5c2e7;
        }
        #pulseaudio.muted {
            font-weight: bold;
            background-color: #89b4fa;
            color: #181825;
        }

        #clock {
            font-weight: bold;
            background-color: #f9e2af;
            color: #11111b;
        }
        #clock:hover {
            background-color: #fab387;
        }

        #custom-distrologo {
            color: #cba6f7;
            margin: 4px 0px;
        }

        #battery {
            background-color: rgb(166, 227, 161);
            color: #11111b;
        }
        #battery:hover {
            background-color: #89dceb;
            color: #11111b;
        }

        #window {
        }

        /* WORKSPACES */

        #workspaces {
            padding: 0px 2px;
            margin: 4px 0px;
            background-color: #313244;
            border-radius: ${cfg.cornerRadius};
        }

        #workspaces button {
            font-weight: bold;
            padding: 2px 0px;
            margin: 0px 2px;
            border-radius: ${cfg.cornerRadius};
            color: #f5e0dc;
        }

        #workspaces button:hover {
            background-color: #1e1e2e;
            color: #f5e0dc;
        }

        #workspaces button.focused {
            background-color: #1e1e2e;
        }

        #workspaces button.active {
            background-color: rgba(180, 190, 254, 1);
            color: #11111b;
        }

        #workspaces button.urgent {
            background-color: #cba6f7;
            color: #11111b;
        }

        #mode {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        @keyframes blink {
            to {
                background-color: @color15;
                color: @color13;
            }
        }

        #battery.critical:not(.charging) {
            background-color: #f38ba8;
            color: #11111b;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: @background;
        }
      '';
    };
  };
}
