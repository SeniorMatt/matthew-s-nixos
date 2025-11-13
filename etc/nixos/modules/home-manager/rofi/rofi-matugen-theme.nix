{lib, config, pkgs, inputs, ...}:
{
  options.rofi = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "0";
    };
  };

  config = with config.rofi; {
    programs.rofi.theme = "${config.home.homeDirectory}/.config/rofi/setup.rasi";
    xdg.configFile."rofi/setup.rasi".text = ''
      @import "rofi-colors"
      * {
        border-radius: ${cornerRadius};
        background-color: @on-primary-fixed-variant;
        text-color: @on-surface;
        font: "JetBrains Mono 26";
        width: 12em;
      }

      element {
        orientation: horizontal;
        children: [ element-text ];
        spacing: 4px;
        cursor: pointer;
      }

      window {
        border-color: @primary;
        border: 4px;
      }

      entry{ 
        expand: true;
        background-color: @on-primary;
        placeholder: "...";
      }

      element-text {
        cursor: pointer;
        background-color: @primary-container;
        text-color: @on-surface;
        vertical-align: 0.5;
        horizontal-align: 0;
      }
      element-text selected, element-icon selected {
        background-color: @on-primary;
        border-radius: 0;
      }

      element-icon {
        size:1em;
      }
    '';
  };
}
