{ config, lib, ...}: 
{
  options.waybar = with lib;{
    cornerRadius = mkOption {
      type = types.str;
      default = "8";
    };
  };
  config = with config.waybar; {
    programs.waybar.style = ''
      * {
          font-family: JetBrainsMono Nerd Font Propo;
          font-size: 13px;
          /*transition: all 200ms cubic-bezier(0.4, 0, 1, 1);*/
          transition: all 250ms ease;
          border-radius: ${cornerRadius};
      }

      window#waybar {
          background-color: rgba(30, 30, 46, 1);
          border-radius: 0px;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;

          margin: 0px 2px;
          padding: 0px 2px;
          color: #cdd6f4;
          background-color: rgba(49, 50, 68, 1);
          border-radius: ${cornerRadius};
      }

      #custom-power {
          background-color: #f38ba8;
          color: #11111b;
      }
      #custom-power:hover {
          background-color: #eba0ac;
          min-width: 48px;
      }

      #pulseaudio {
          background-color: #cba6f7;
          color: #11111b;
      }
      #pulseaudio.muted:hover,
      #pulseaudio:hover {
          background-color: #f5c2e7;
          min-width: 80px;
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
          margin: 0px 0px;
      }

      #battery {
          background-color: rgb(166, 227, 161);
          color: #11111b;
      }

      /* WORKSPACES */

      #workspaces {
          margin: 0px 4px;
          background-color: #313244;
          border-radius: ${cornerRadius};
      }

      #workspaces button {
          font-weight: bold;
          border-radius: ${cornerRadius};
          color: #f5e0dc;
      }

      #workspaces button:hover {
          background-color: #1e1e2e;
          color: #f5e0dc;
          min-width: 32px;
      }

      #workspaces button.focused {
          background-color: #1e1e2e;
      }

      #workspaces button.active {
          background-color: #1e1e2e;
          color: #b4befe;
          box-shadow: inset 0 -2px 0 #b4befe;
          min-width: 48px;
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
}
