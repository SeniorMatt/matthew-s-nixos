{ config, pkgs, inputs, ... }:

{
  imports = [
    ./theme-breeze.nix
  ];

  home.packages = with pkgs; [
    kdePackages.kalk
    kdePackages.kclock
  ];
  
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    fonts = {
      fixedWidth = {
	family = "JetBrains Mono";
        pointSize = 12;
      };
      general = {
	family = "Noto Sans";
        pointSize = 12;
      };
      menu = {
	family = "Noto Sans";
        pointSize = 12;
      };
      small = {
	family = "Noto Sans";
        pointSize = 10;
      };
      toolbar = {
	family = "Noto Sans";
        pointSize = 12;
      };
      windowTitle = {
	family = "Noto Sans";
        pointSize = 12;
      };
    };
    
    # Run this to locate the ID's and names
    # grep -E 'Name|Handlers' -B1 /proc/bus/input/devices

    input = {
      keyboard = {
        layouts = [
          {
            layout = "us";
          }
          {
            layout = "ru";
          }
        ];
	switchingPolicy = "global";
        options = [ "grp:caps_toggle" ];
      };

      touchpads = [
        {
          disableWhileTyping = false;
	  enable = true;
          name = "Synaptics TM3276-022";
          productId = "0000";
          vendorId = "06cb";
	}
      ];
      
      mice = [
        {
          accelerationProfile = "none";
          name = "TPPS/2 IBM TrackPoint";
          productId = "000a";
          vendorId = "0002";
        }
        {
          accelerationProfile = "none";
          name = "Compx 2.4G Wireless Receiver";
          productId = "fa7c";
          vendorId = "25a7";
        }
      ];
    };

    workspace = {
      wallpaper = "/home/matthew/Pictures/wallhaven-je5wl5.jpg";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Breeze Dark";
        size = 24;
      };
    };

    kwin = {
      nightLight = {
        enable = true;
	location.latitude = "43.24";
	location.longitude = "76.88";
	mode = "location";
	temperature.night = 4500;
      };

      virtualDesktops = {
        number = 3;
	rows = 1;
      };
    };

    configFile = {
      kdeglobals = {
        General = {
          accentColorFromWallpaper = true;
	};
      };
    };

    shortcuts = {
      "services/firefox.desktop" = {
        "_launch" = "Meta+Shift+F";
      };

      "services/org.telegram.desktop.desktop" = {
        "_launch" = "Meta+Shift+T";
      };

      "services/obsidian.desktop" = {
        "_launch" = "Meta+Shift+O";
      };

      "services/kitty.desktop" = {
        "_launch" = "Meta+Shift+C";
      };

      ksmserver = {
        "LogOut" = [
          "Meta+M"
        ];
      };

      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "Meta+0";

        "Window Move Center" = "Ctrl+Alt+C";
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";

        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Desktop 10" = "Meta+)";
      };
    };

    panels = [
      {
        floating = true;
        height = 54;
        lengthMode = "fill";
        location = "bottom";
        opacity = "adaptive";
	widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
	  {
            iconTasks = {
              launchers = [
	        # Run list these directories
		# to find .desktop files
		# /etc/profiles/per-user/matthew/share/applications/ for per user apps
		# /run/current-system/sw/share/applications/ for system apps

                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
		"applications:org.telegram.desktop.desktop"
		"applications:obsidian.desktop"
		"applications:kitty.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.volume"
              ];
              hidden = [
                "org.kde.plasma.networkmanagement"
              ];
            };
          }
	  {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "12h";
            };
          }
	];
      }
    ];
    
    session = {
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };
  };
}
