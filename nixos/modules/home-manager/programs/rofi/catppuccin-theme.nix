{ lib, config, pkgs, ... }:
let
  cornerRadius = builtins.toString config.rofi.cornerRadius;
in
{
  config = lib.mkIf (config.rofi.theme == "catppuccin") {
    programs.rofi.theme = "${pkgs.writeText "config.rasi" ''
      * {
        base: #181825; 
        text: #cdd6f4;
        lightbase: #1e1e2e;
        accent: #b4befe;
        border-radius: ${cornerRadius};
        background-color: @base;
        text-color: @text;
        font: "JetBrains Mono 26";
        width: 12em;
      }

      element {
        orientation: horizontal;
        children: [ element-text ];
        spacing: 0px;
        cursor: pointer;
        margin: 2 16;
      }

      window {
        border-color: @accent;
        border: 2px;
      }

      entry{ 
        background-color: @lightbase;
      }

      element-text {
        cursor: pointer;
        background-color: @base;
        text-color: @text;
        vertical-align: 0.5;
        horizontal-align: 0;
      }
      element-text selected, element-icon selected {
        background-color: @accent;
        text-color: @base;
        border-radius: 0;
      }

      element-icon {
        size:1em;
      }
    ''}";
  };
}
