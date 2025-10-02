{
  inputs,
  pkgs,
  config,
  ...
}: let
  # Theme
  # config.home.homeDirectory - To access home directory
  # wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png";
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/buildings.jpg";
  generalFont = "Noto Sans";
  fixedFont = "JetBrainsMono";
  generalFontSize = 12;
  smallFontSize = 10;
in {
  imports = [
    ./theme-breeze.nix # GTK, QT and Cursor themes
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  # Widgets
  home.file.".local/share/plasma/plasmoids/AndromedaLauncher".source = ./plasma-widgets/AndromedaLauncher;

  home.packages = with pkgs; [
    mpv # Media player
    kdePackages.kcalc # Calculator app
    kdePackages.kclock # Clock app
  ];

  # Plasma Manager
  # https://nix-community.github.io/plasma-manager/options.xhtml
  # Check this site to find available options
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Default fonts
    # Any else: Noto Sans 10pt
    # Small: Noto Sans 8pt
    # FixedWidth: Hack 10pt

    fonts = {
      fixedWidth = {
        family = fixedFont;
        pointSize = generalFontSize;
      };
      general = {
        family = generalFont;
        pointSize = generalFontSize;
      };
      menu = {
        family = generalFont;
        pointSize = generalFontSize;
      };
      small = {
        family = generalFont;
        pointSize = smallFontSize;
      };
      toolbar = {
        family = generalFont;
        pointSize = generalFontSize;
      };
      windowTitle = {
        family = generalFont;
        pointSize = generalFontSize;
      };
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      soundTheme = "freedesktop";
      cursor = {
        theme = "breeze_cursors";
        size = 24;
      };
      iconTheme = "breeze-dark";
      wallpaper = wallpaper;
    };

    kscreenlocker = {
      #appearance.showMediaControls = false;
      appearance.wallpaper = wallpaper;
      #autoLock = false;
      #timeout = 0;
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
      kwin = {
        "Activate Application Launcher" = "";
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
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
      ksmserver = {
        "LogOut" = [
          "Meta+M"
        ];
      };
    };

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
        options = ["grp:caps_toggle"];
        repeatDelay = 600;
        repeatRate = 25;
      };
      mice = [
        {
          enable = true;
          acceleration = 0.0;
          accelerationProfile = "none";
          name = "TPPS/2 Elan TrackPoint";
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
      touchpads = [
        {
          disableWhileTyping = false;
          enable = true;
          naturalScroll = true;
          pointerSpeed = 0;
          tapToClick = true;

          name = "Synaptics TM3276-022";
          vendorId = "06cb";
          productId = "0000";
        }
      ];
    };

    window-rules = [
      {
        description = "Window settings for firefox";
        match = {
          window-class = {
            value = "firefox";
            type = "substring";
          };
          window-types = ["normal"];
          title = {
            value = "Picture-in-Picture";
            type = "substring";
          };
        };
        apply = {
          above = {
            value = true;
            apply = "force";
          };
          desktops = {
            value = "\\0";
            apply = "force";
          };
        };
      }
    ];

    kwin = {
      effects = {
        #blur.enable = true;
        #cube.enable = false;
        #desktopSwitching.animation = "off";
        #dimAdminMode.enable = false;
        #dimInactive.enable = false;
        #fallApart.enable = false;
        #fps.enable = false;
        #minimization.animation = "off";
        #shakeCursor.enable = false;
        #slideBack.enable = false;
        #snapHelper.enable = false;
        #translucency.enable = false;
        #windowOpenClose.animation = "off";
        #wobblyWindows.enable = false;
      };

      nightLight = {
        enable = true;
        location.latitude = "43.2";
        location.longitude = "76.9";
        mode = "location";
        temperature.night = 4000;
      };

      virtualDesktops = {
        number = 3;
        rows = 1;
      };
    };

    panels = [
      {
        location = "top";
        height = 44;
        screen = 0;
        floating = true;
        widgets = [
          "org.kde.plasma.kickoff" # Default start menu
          #"AndromedaLauncher" # Andromeda launcher
          "org.kde.plasma.pager" # Workspace switcher
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  # You can get the Applications running get-all-apps.sh script
                  "applications:systemsettings.desktop"
                  "applications:firefox.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:vesktop.desktop"
                  "applications:obsidian.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:kitty.desktop"
                ];
              };
            };
          }
          "org.kde.plasma.marginsseparator" # spacer
          {
            # systray (net, sound, bt, battery…)
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.battery"
              ];
              hidden = [
              ];
            };
          }
          "org.kde.plasma.digitalclock" # clock
        ];
      }
    ];

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        powerProfile = "performance";
      };
      battery = {
        autoSuspend.action = "sleep";
        powerProfile = "balanced";
      };
    };

    configFile = {
      "kdeglobals" = {
        "General" = {
          TerminalApplication = "kitty";
          TerminalService = "kitty.desktop";
        };
      };
    };
  };

  # Spectacle
  home.file.".config/spectaclerc".text = ''
    [GuiConfig]
    quitAfterSaveCopyExport=true
  '';

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "video/mp4" = "mpv.desktop";
      "audio/mp3" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "application/pdf" = "org.kde.okular.desktop";
    };
  };
}
