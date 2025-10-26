{pkgs, lib, config, ...}:
{
  options.rofi = with lib; {
    cornerRadius = mkOption {
      type = types.str;
      default = "8";
    };
  };

  config = with config.rofi; {
    programs.rofi = {
      enable = true;
      font = "JetBrains Mono 20";
      modes = [
        "emoji"
        "calc"
      ];
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
      extraConfig = {
        # Keybinds
        kb-remove-char-back = "Alt+h,BackSpace,Shift+BackSpace";
        kb-mode-complete = "Alt+l";
        kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
        kb-row-down = "Down,Control+j";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-remove-to-eol = "Control+Shift+e";
        kb-mode-next = "Control+l";
        kb-mode-previous = "Control+h";

        display-drun = "[Apps]";
        display-run = "[Packages]";
        display-emoji = "[Emoji]";
        display-calc = "[Calculator]";
        drun-display-format = "{name} {icon}";
        show-icons = true;
      };
      theme = "~/.config/rofi/theme.rasi";
    };

    xdg.configFile."qalculate/theme.rasi".text = ''

    '';
    xdg.configFile."rofi/theme.rasi".text = ''
      * {
        /* mocha */
        base:     #1e1e2e;
        mantle:   #181825;
        text:     #cdd6f4;
        red:      #f38ba8;
        blue:     #89b4fa;
        lavender: #b4befe;

        foreground: @text;
        background: @base;
        lightbg:    @mantle;
        lightfg:    @text;

        selected-active-foreground:  @background;
        lightfg:                     @text;
        separatorcolor:              @foreground;
        urgent-foreground:           @red;
        alternate-urgent-background: @lightbg;
        lightbg:                     @mantle;
        background-color:            transparent;
        border-color:                @foreground;
        normal-background:           @background;
        selected-urgent-background:  @red;
        alternate-active-background: @lightbg;
        spacing:                     2;
        alternate-normal-foreground: @foreground;
        urgent-background:           @background;
        selected-normal-foreground:  @lightbg;
        active-foreground:           @blue;
        background:                  @base;
        selected-active-background:  @blue;
        active-background:           @background;
        selected-normal-background:  @lightfg;
        alternate-normal-background: @lightbg;
        foreground:                  @text;
        selected-urgent-foreground:  @background;
        normal-foreground:           @foreground;
        alternate-urgent-foreground: @red;
        alternate-active-foreground: @blue;
        border-radius: ${cornerRadius};
      }

      element {
        padding: 1px;
        margin: 4;
        cursor:  pointer;
        spacing: 5px;
        border:  0;
      }
      element normal.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
      }
      element normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
      }
      element normal.active {
        background-color: @active-background;
        text-color:       @active-foreground;
      }
      element selected.normal {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
      }
      element selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @selected-urgent-foreground;
      }
      element selected.active {
        background-color: @selected-active-background;
        text-color:       @selected-active-foreground;
      }
      element alternate.normal {
        background-color: @alternate-normal-background;
        text-color:       @alternate-normal-foreground;
      }
      element alternate.urgent {
        background-color: @alternate-urgent-background;
        text-color:       @alternate-urgent-foreground;
      }
      element alternate.active {
        background-color: @alternate-active-background;
        text-color:       @alternate-active-foreground;
      }
      element-text {
        background-color: transparent;
        cursor:           inherit;
        highlight:        inherit;
        text-color:       inherit;
      }
      element-icon {
        background-color: transparent;
        size:             1.0000em;
        cursor:           inherit;
        text-color:       inherit;
      }

      window {
        padding:          5;
        background-color: @background;
        border:           4;
        border-radius: ${cornerRadius};
      }
      mainbox { padding: 0; border: 0; }
      message {
        padding:      1px;
        /* border-color: @separatorcolor;
        border:       2px dash 0px 0px; */
      }
      textbox { text-color: @foreground; }
      listview {
        padding:        2px 0px 0px;
        scrollbar:      true;
        spacing:        2px;
        fixed-height:   0;
        /* border-color:   @separatorcolor;
        border:         2px dash 0px 0px; */
      }
      scrollbar {
        width:         4px;
        padding:       0;
        handle-width:  8px;
        border:        0;
        handle-color:  @normal-foreground;
      }
      sidebar {
        /* border-color: @separatorcolor;
        border:       2px dash 0px 0px; */
      }

      button {
        cursor:      pointer;
        spacing:     0;
        text-color:  @normal-foreground;
      }
      button selected {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
      }
      num-filtered-rows {
        expand:     false;
        text-color: Gray;
      }
      num-rows {
        expand:     false;
        text-color: Gray;
      }
      textbox-num-sep {
        expand:     false;
        str:        "/";
        text-color: Gray;
      }

      inputbar {
        padding:    1px;
        spacing:    0px;
        text-color: @normal-foreground;
        children:   [ "prompt","textbox-prompt-colon","entry","num-filtered-rows","textbox-num-sep","num-rows","case-indicator" ];
      }
      case-indicator {
        spacing:    0;
        text-color: @normal-foreground;
      }
      entry {
        text-color:        @normal-foreground;
        cursor:            text;
        spacing:           0;
        placeholder-color: Gray;
        placeholder:       "...";
      }
      prompt {
        spacing:    0;
        text-color: @normal-foreground;
      }
      textbox-prompt-colon {
        margin:     0px 0.3000em 0.0000em 0.0000em;
        expand:     false;
        str:        ":";
        text-color: inherit;
      }
    '';
  };
}
