{ config, lib, ...}: 
{
  options.waybar = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "0";
    };
  };
  config = with config.waybar; {
    programs.waybar.style = ''
      @import "colors.css";
      * {
          font-family: JetBrainsMono Nerd Font Propo;
          font-size: 13pt;
          transition: min-width 250ms ease;
          border-radius: ${cornerRadius};
          margin: 0;
          padding: 0;
      }

      window#waybar {
          background-color: @surface-alpha;
          border-radius: 0px;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          color: @on_surface;
          background-color: @surface;
      }

      #custom-power,
      #language,
      #workspaces,
      #custom-distrologo,
      #window {
          padding: 0 2;
          margin: 0 4;
          color: @primary;
      }

      #clock,
      #pulseaudio,
      #battery {
          color: @primary;
          padding: 0 2;
          margin: 0 2;
      }

      #clock:hover,
      #pulseaudio:hover {
          background-color: @surface_bright;
          min-width: 80px;
      }

      #custom-power:hover {
          background-color: @surface_bright;
          min-width: 48px;
      }

      #workspaces {
          background-color: @surface;
          padding: 0 8;
          border-radius: ${cornerRadius};
          color: @on_surface;
      }

      #workspaces button {
          padding: 0 8;
          color: @primary;
          background-color: @surface_container_highest;
      }

      #workspaces button:hover {
          min-width: 24px;
      }

      #workspaces button.active {
          background-color: @primary;
          color: @surface_container_highest;
          min-width: 32px;
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
}
