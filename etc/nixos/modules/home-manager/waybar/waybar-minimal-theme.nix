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
          background-color: #303030;
          border-bottom: 4px solid #404040;
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
