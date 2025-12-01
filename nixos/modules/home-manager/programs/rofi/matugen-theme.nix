{ lib, config, ... }:
let
  cornerRadius = builtins.toString config.rofi.cornerRadius;
in
{
  config = lib.mkIf (config.rofi.theme == "matugen") {
    programs.rofi.theme = "${config.home.homeDirectory}/.config/rofi/setup.rasi";
    xdg.configFile."rofi/setup.rasi".text = ''
      @import "rofi-colors"
      * {
        border-radius: ${cornerRadius};
        background-color: @surface;
        text-color: @on-surface;
        font: "JetBrains Mono 26";
        width: 12em;
      }

      element {
        orientation: horizontal;
        children: [ element-text ];
        /* spacing: 4px; */
        margin: 2 4;
        cursor: pointer;
      }

      window {
        border-color: @primary;
        border: 4px;
      }

      entry { 
        expand: true;
        background-color: @on-primary;
        placeholder: "...";
        margin: 10 10;
      }

      prompt {
        margin: 10 10;
      }

      element-text {
        cursor: pointer;
        text-color: @on-surface;
        vertical-align: 0.5;
        horizontal-align: 0;
      }
      element-text selected, element-icon selected {
        background-color: @primary-container;
        border-radius: 0;
      }

      element-icon {
        size:1em;
      }
    '';
  };
}
