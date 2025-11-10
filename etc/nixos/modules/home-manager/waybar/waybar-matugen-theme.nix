{ config, lib, ...}: 
{
  options.waybar = with lib;{
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
          transition: all 250ms ease;
          border-radius: 6px;
          margin: 0;
          padding: 0;
      }

      window#waybar {
          background-color: @surface;
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
          /* color: @on_surface; */
          padding: 0 2;
          margin: 0 4;
          color: @on_primary_container;
      }

      #clock,
      #pulseaudio,
      #battery {
          color: @on_surface;
          padding: 0 2;
          margin: 0 2;
      }

      #custom-power:hover,
      #clock:hover,
      #pulseaudio:hover {
          background-color: @surface_bright;
          min-width: 80px;
      }

      #workspaces {
          /* background-color: #000000; */
          background-color: @inverse_on_surface;
          padding: 0 8;
          border-radius: 6px;
      }

      #workspaces button {
          padding: 0 8;
          color: @on_primary_fixed_variant;
          background-color: @on_primary;
      }

      #workspaces button:hover {
          background-color: @on_primary_fixed_variant;
          min-width: 24px;
      }

      #workspaces button.active {
          background-color: @on_primary_fixed_variant;
          box-shadow: inset 0px -4px @source_color;
          color: @on_primary_container;
          min-width: 32px;
          /* border-bottom: 4px solid @source_color; */
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
