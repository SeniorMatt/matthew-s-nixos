{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile = {
    "waybar/config.jsonc".text = ''
      // -*- mode: jsonc -*-
      {
          "layer": "top", // Waybar at top layer
          "position": "top", // Waybar position (top|bottom|left|right)
          // "height": 48, // Waybar height (to be removed for auto height)
          // "width": 1280, // Waybar width
          "margin-left": 0,
          "margin-right": 0,
          "margin-top": 0,
          "spacing": 8,
          "modules-left": [
              "hyprland/workspaces",
              "battery",
              "battery#bat1",	// Comment this line to remove second battery
              "cpu",
              "memory",
              "temperature"
          ],
          "modules-center": [
              "custom/distrologo"
          ],
          "modules-right": [
              "hyprland/language",
              "tray",
              "pulseaudio",
              "backlight",
              "keyboard-state",
              "clock",
              /* "power-profiles-daemon", */
              "custom/power"
          ],
          // Modules configuration
          "hyprland/workspaces": {
              "disable-scroll": true,
              "all-outputs": true,
              "warp-on-scroll": false,
              "format": "{name}",
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
          "keyboard-state": {
              "numlock": true,
              "capslock": true,
              "format": "{name} {icon}",
              "format-icons": {
                  "locked": "",
                  "unlocked": ""
              }
          },
          "sway/mode": {
              "format": "<span style=\"italic\">{}</span>"
          },
          "sway/scratchpad": {
              "format": "{icon} {count}",
              "show-empty": false,
              "format-icons": ["", ""],
              "tooltip-format": "{app}: {title}",
              "tooltip": true
          },
          "mpd": {
              "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
              "format-disconnected": "Disconnected ",
              "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
              "unknown-tag": "N/A",
              "interval": 5,
              "consume-icons": {
                  "on": " "
              },
              "random-icons": {
                  "off": "<span color=\"#f53c3c\"></span> ",
                  "on": " "
              },
              "repeat-icons": {
                  "on": " "
              },
              "single-icons": {
                  "on": "1 "
              },
              "state-icons": {
                  "paused": "",
                  "playing": ""
              },
              "tooltip-format": "MPD (connected)",
              "tooltip-format-disconnected": "MPD (disconnected)"
          },
          "idle_inhibitor": {
              "format": "{icon}",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
          },
          "tray": {
              "icon-size": 24,
              "spacing": 10
          },
          "clock": {
              // "timezone": "America/New_York",
              "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
              "format-alt": "[{:%Y-%m-%d}]",
              "format": "[{:%H:%M}]"
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
              // "thermal-zone": 2,
              // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
              "critical-threshold": 80,
              // "format-critical": "{temperatureC}°C {icon}",
              "format":  "[{icon} {temperatureC}°C]",
              "format-icons": [""]
          },
          "backlight": {
              // "device": "acpi_video1",
              // "format": "{percent}% {icon}",
              "format": "{icon}",
              "format-icons": ["", "", "", "", "", "", "", "", ""],
              "tooltip": true,
              "tooltip-format": "Backlight: {percent}%"
          },
          "battery": {
              "bat": "BAT0",
              "states": {
                  // "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "[{capacity}% {icon}]",
              "format-full": "[{capacity}% {icon}]",
              "format-charging": "[{capacity}% ]",
              "format-plugged": "[{capacity}% ]",
              "format-alt": "[{time} {icon}]",
              // "format-good": "", // An empty format will hide the module
              // "format-full": "",
              "format-icons": ["", "", "", "", ""]
          },
          "battery#bat1": {
              "bat": "BAT1",
              "states": {
                  // "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "[{capacity}% {icon}]",
              "format-full": "[{capacity}% {icon}]",
              "format-charging": "[{capacity}% ]",
              "format-plugged": "[{capacity}% ]",
              "format-alt": "[{time} {icon}]",
              // "format-good": "", // An empty format will hide the module
              // "format-full": "",
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
          "network": {
              // "interface": "wlp2*", // (Optional) To force the use of this interface
              "format-wifi": "{essid} ({signalStrength}%)  ",
              "format-ethernet": "{ipaddr}/{cidr}  ",
              "tooltip-format": "{ifname} via {gwaddr}  ",
              "format-linked": "{ifname} (No IP)  ",
              "format-disconnected": "Disconnected ⚠ ",
              "format-alt": "{ifname}: {ipaddr}/{cidr}"
          },
          "pulseaudio": {
              "scroll-step": 1, // %, can be a float
              "format": "{volume}% {icon}",
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
          "custom/media": {
              "format": "{icon} {text}",
              "return-type": "json",
              "max-length": 40,
              "format-icons": {
                  "spotify": "",
                  "default": "🎜"
              },
              "escape": true,
              "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
              // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
          },
          "custom/power": {
              "format" : "[⏻]",
      		"tooltip": false,
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
            "on-click": "kitty --hold bash -c nitch"
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
      }

      window#waybar {
          background-color: rgba(30, 30, 46, 1.0);
          border-radius: 0px;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      #battery,
      #disk,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #tray,
      #clock,
      #language,
      #custom-power,
      #power-profiles-daemon,
      #custom-wifi,
      #custom-bluetooth,
      #cpu,
      #temperature,
      #memory,
      #mpd {
          margin: 4px 0px;
          padding: 0px 4px;
          color: #cdd6f4;
          border-radius: 8px;
      }

      #custom-power {
          padding: 2px 10px;
          background-color: #f38ba8;
          color: #11111b;
      }

      #custom-power:hover {
          background-color: #cba6f7;
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

      #disk:hover,
      #backlight:hover,
      #network:hover,
      #pulseaudio:hover,
      #pulseaudio.muted:hover,
      #wireplumber:hover,
      #custom-media:hover,
      #mode:hover,
      #idle_inhibitor:hover,
      #scratchpad:hover,
      #power-profiles-daemon:hover,
      #custom-wifi:hover,
      #custom-bluetooth:hover,
      #mpd:hover {
        background-color: rgba(49, 50, 68, 1);
      }

      #window {
          margin: 0 4px;
      }

      /* WORKSPACES */

      #workspaces {
          padding: 2px 2px;
          margin: 4px 0px;
          background-color: rgba(49, 50, 68, 0.0);
          border-radius: 8px;
      }

      #workspaces button {
          font-weight: bold;
          padding: 0px 2px;
          margin: 0px 0px;
          border-radius: 8px;
          color: #f5e0dc;
      }

      #workspaces button:hover {
          background-color: rgba(17, 17, 27, 1);
      }

      #workspaces button.focused {
          background-color: rgba(243, 139, 168, 1);
      }

      #workspaces button.active {
          background-color: rgba(180, 190, 254, 1);
          color: #11111b;
      }

      #workspaces button.urgent {
          background-color: #cdd6f4;
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

      label:focus {
          background-color: #000000;
      }

      #disk {
          background-color: #964B00;
      }

      #pulseaudio.muted {
          font-weight: bold;
          background-color: #94e2d5;
          color: #181825;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @background;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

      #privacy {
          padding: 0;
      }

      #privacy-item {
          padding: 0 5px;
          color: white;
      }

      #privacy-item.screenshare {
          background-color: #cf5700;
      }

      #privacy-item.audio-in {
          background-color: #1ca000;
      }

      #privacy-item.audio-out {
          background-color: #0069d4;
      }
    '';
  };
}
