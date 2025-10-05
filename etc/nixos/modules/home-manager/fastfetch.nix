{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.configFile = {
    "fastfetch/config.jsonc".text = ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json",
        "logo": {
          "source": "~/Pictures/avatar-circle.png"
        },
        "modules": [
          "break",
          "title",
          "break",
          //"separator",
          {
            "type": "custom",
            "format": "********************************",
            "keyColor": "34" // = color4
          },
          //"os",
          {
              "type": "os",
              "key": "~ ",
              "keyColor": "34" // = color4
          },
          {
              "type": "host",
              "key": "~ ",
              "keyColor": "34"
          },
          {
              "type": "kernel",
              "key": "~ ",
              "keyColor": "34"
          },
          //"uptime",
          {
              "type": "packages",
              "key": "~ ",
              "keyColor": "34"
          },
          {
              "type": "shell",
              "key": "~ ",
              "keyColor": "34",
          },
          //"display",
          {
              "type": "de",
              "key": "~ ",
              "keyColor": "34",
          },
          {
              "type": "wm",
              "key": "~ ",
              "keyColor": "34",
          },
          //"wmtheme",
          //"theme",
          //"icons",
          //"font",
          {
              "type": "terminalfont",
              "key": "~ ",
              "keyColor": "34",
          },
          {
              "type": "terminal",
              "key": "~ ",
              "keyColor": "34",
          },
          //"cursor",
          //"terminal",
          //"terminalfont",
          //"cpu",
          //"gpu",
          //"memory",
          //"swap",
          //"disk",
          //"localip",
          //"battery",
          //"poweradapter",
          //"locale",
          {
            "type": "custom",
            "format": "********************************",
          },
          "break",
          "colors",
          "break"
        ]
      }
    '';
  };
}
