{pkgs, ...}:
{
  programs.rofi = {
    enable = true;
    font = "JetBrains Mono 20";
    modes = [
      "drun"
      "calc"
      "emoji"
      "run"
    ];
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    extraConfig = {
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
      show-icons = false;
    };
  };
}
