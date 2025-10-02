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
          "title",
          "break",
          //"separator",
          {
            "type": "custom",
            "format": "~~~~~~~~~~~~~~~~~~~~~~~~~~",
            "keyColor": "34" // = color4
          },
          //"os",
          {
              "type": "os",
              "key": "os ~ ",
              "keyColor": "34" // = color4
          },
          {
              "type": "host",
              "key": "host ~ ",
              "keyColor": "34"
          },
          {
              "type": "kernel",
              "key": "kernel ~ ",
              "keyColor": "34"
          },
          //"uptime",
          {
              "type": "packages",
              "key": "packages ~ ",
              "keyColor": "34"
          },
          {
              "type": "shell",
              "key": "shell ~ ",
              "keyColor": "34",
          },
          //"display",
          {
              "type": "de",
              "key": "desktop environment ~ ",
              "keyColor": "34",
          },
          {
              "type": "wm",
              "key": "wm ~ ",
              "keyColor": "34",
          },
          //"wmtheme",
          //"theme",
          //"icons",
          //"font",
          {
              "type": "font",
              "key": "font ~ ",
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
            "format": "~~~~~~~~~~~~~~~~~~~~~~~~~~",
          },
          "break",
          "colors"
        ]
      }
    '';
  };
}
