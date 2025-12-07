{
  programs.fastfetch = {
    enable = true;
    settings = {
      # logo.source = "~/Matthew-s-NixOS/pictures/avatar-circle.png";
      logo = {
        source = "~/Matthew-s-NixOS/pictures/nixos-logo.png";
        padding.bottom = 8;
      };
      modules = [
        "break"
        "title"
        "break"

        {
          type = "custom";
          format = "123456789012345678901234567890123456789123456789";
          keyColor = "34";
        }

        "break"

        {
          type = "os";
          key = "[os]";
          keyColor = "34";
        }
        {
          type = "host";
          key = "[host]";
          keyColor = "34";
        }
        {
          type = "kernel";
          key = "[kernel]";
          keyColor = "34";
        }
        {
          type = "packages";
          key = "[pkgs]";
          keyColor = "34";
        }
        {
          type = "shell";
          key = "[shell]";
          keyColor = "34";
        }
        {
          type = "de";
          key = "[de]";
          keyColor = "34";
        }
        {
          type = "wm";
          key = "[wm]";
          keyColor = "34";
        }
        {
          type = "terminalfont";
          key = "[font]";
          keyColor = "34";
        }
        {
          type = "terminal";
          key = "[terminal]";
          keyColor = "34";
        }

        "break"

        {
          type = "custom";
          format = "123456789012345678901234567890123456789123456789";
        }

        "break"
        "colors"
        "break"
      ];
    };
  };
}
