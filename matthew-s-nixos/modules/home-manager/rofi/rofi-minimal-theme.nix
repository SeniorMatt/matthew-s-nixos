{lib, config, pkgs, ...}:
{
  options.rofi = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "0";
    };
  };

  config = with config.rofi; {
    programs.rofi.theme = "${pkgs.writeText "config.rasi" ''
      * {
        base: #000000;
        text: #f0f0f0;
        lightbase: #202020;
        accent: #999999;
        border-radius: ${cornerRadius};
        background-color: @base;
        text-color: @text;
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
        border-color: @accent;
        border: 2px;
      }

      entry{ 
        expand: true;
        background-color: @lightbase;
        placeholder: "...";
      }

      element-text {
        cursor: pointer;
        background-color: @base;
        text-color: @text;
        vertical-align: 0.5;
        horizontal-align: 0;
      }
      element-text selected, element-icon selected {
        background-color: @lightbase;
        border-radius: 0;
      }

      element-icon {
        size:1em;
      }
    ''}";
  };
}
