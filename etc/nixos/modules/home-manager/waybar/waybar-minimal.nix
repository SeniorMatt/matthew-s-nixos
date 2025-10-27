{
  pkgs,
  config,
  lib,
  ...
}: 
{
  options.waybar = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "0";
    };
  };

  config = with config.waybar; {
    home.packages = with pkgs; [waybar];
    xdg.configFile = {
      "waybar/config.jsonc".text = ''
        {
            "layer": "top",
            "position": "bottom", // top, bottom, left, right
            "margin-left": 0,
            "margin-right": 0,
            "margin-top": 0,
            "spacing": 8,
            "modules-left": [
                "custom/distrologo",
                "niri/workspaces",
            ],
            "modules-center": [
                "niri/window",
            ],
            "modules-right": [
                "niri/language",
                "tray",
                "battery",
                "battery#bat1",
                "pulseaudio",
                "clock",
                "custom/power",
            ],
            // Modules configuration
            "niri/language": {
                "format": "{short}"
            },
            "tray": {
                "icon-size": 16,
                "spacing": 2
            },
            "clock": {
                "format": "{:%H:%M}",
                "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
            },
            "battery": {
                "bat": "BAT0",
                "states": {
                    "good": 85,
                    "warning": 30,
                    "critical": 15
                },
                "format": "{capacity}% {icon}",
                "format-full": "{capacity}% {icon}",
                "format-charging": "{capacity}% ",
                "format-plugged": "{capacity}% ",
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
                "format": "{capacity}% {icon}",
                "format-full": "{capacity}% {icon}",
                "format-charging": "{capacity}% ",
                "format-plugged": "{capacity}% ",
                "format-icons": ["", "", "", "", ""]
            },
            "pulseaudio": {
                "scroll-step": 2.5, // %, can be a float
                "format": "{icon} {volume}%",
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
                "format" : "⏻",
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
              "format": "{icon}",
              "tooltip-format": "I'm using NixOS BTW",
              "tooltip": true,
              "format-icons": {
                "default": ""
              },
            },
        }
      '';

      "waybar/style.css".text = ''
        * {
            font-family: JetBrainsMono Nerd Font Propo;
            font-size: 13pt;
            transition-duration: 0s;
            transition-property: background-color;
            padding: 0 4;
            margin: 0;
            border-radius: ${cornerRadius}px;
        }

        window#waybar {
            background-color: black;
            border-radius: 0px;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            color: white;
            background-color: rgba(32, 32, 32, 1);
        }

        #clock:hover,
        #pulseaudio:hover,
        #battery:hover {
            background-color: rgba(48, 48, 48, 1);
        }

        /* WORKSPACES */

        #workspaces {
            padding: 0px 0px;
            margin: 0px 0px;
            background-color: #313244;
            border-radius: ${cornerRadius}px;
        }

        #workspaces button:hover {
            background-color: rgba(48, 48, 48, 1);
        }

        #workspaces button.active {
            background-color: rgba(64, 64, 64, 1);
            border-bottom: 2px solid #b4befe;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }
      '';
    };
  };
}
