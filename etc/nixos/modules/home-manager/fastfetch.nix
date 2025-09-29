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
          },
          "os",
          "host",
          "kernel",
          //"uptime",
          "packages",
          "shell",
          //"display",
          "de",
          "wm",
          //"wmtheme",
          //"theme",
          //"icons",
          //"font",
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
