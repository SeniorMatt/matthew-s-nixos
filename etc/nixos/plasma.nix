{ config, pkgs, inputs, ... }:

let
  cursor-default-theme = pkgs.runCommandLocal "cursor-default-theme" { } ''
    mkdir -p $out/share/icons
    ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
    '';
in
{

  # Theme setup

  home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";

  home.packages = with pkgs; [
    cursor-default-theme
    kdePackages.kalk
    kdePackages.kclock
  ];
  
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = '' 1 '';
    };
  };
  
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

    hotkeys.commands."launch-kitty" = {
      name = "Launch Kitty";
      key = "Meta+Shift+C";
      command = "kitty";
    };

    hotkeys.commands."launch-obsidian" = {
      name = "Launch Obsidian";
      key = "Meta+Shift+O";
      command = "obsidian";
    };

    hotkeys.commands."launch-telegram" = {
      name = "Launch Telegram";
      key = "Meta+Shift+T";
      command = "Telegram";
    };

    hotkeys.commands."launch-firefox" = {
      name = "Launch Firefox";
      key = "Meta+Shift+F";
      command = "firefox";
    };

    panels = [
      {
        floating = true;
        height = 54;
        lengthMode = "fill";
        location = "bottom";
        opacity = "adaptive";
      }
    ];
    
    session = {
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };
  };
}
