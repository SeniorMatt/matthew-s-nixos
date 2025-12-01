{ lib, config, ...}: 
let
  cornerRadius = builtins.toString config.waybar.cornerRadius;
in
{
  config = lib.mkIf (config.waybar.theme == "minimal") {
    programs.waybar.style = ''
      * {
          font-family: JetBrainsMono Nerd Font Propo;
          font-size: 13pt;
          border-radius: ${cornerRadius}px;
          margin: 0;
          padding: 0;
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

      #power,
      #clock,
      #pulseaudio,
      #battery {
          padding: 0 2;
          margin: 0 2;
      }

      #clock:hover,
      #pulseaudio:hover,
      #battery:hover {
          background-color: rgba(48, 48, 48, 1);
      }

      #workspaces {
          background-color: #000000;
          border-radius: ${cornerRadius}px;
      }

      #workspaces button {
          padding: 0 4;
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
