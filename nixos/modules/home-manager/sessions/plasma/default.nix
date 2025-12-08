{ inputs, pkgs, repoPath, ... }: 
let
  wallpaperFolder = "${repoPath}/pictures/wallpapers"; wallpaper = "${wallpaperFolder}/schreckhorn_switzerland.jpeg";
  generalFont = "Noto Sans";
  fixedFont = "JetBrainsMono";
  generalFontSize = 12;
  fixedFontSize = 14;
  smallFontSize = 10;
  breakReminder = pkgs.stdenv.mkDerivation {
    pname = "Break reminder widget";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "dipzza";
      repo = "break-reminder";
      rev = "main";
      sha256 = "sha256-ldU+JnVmPdTEnn+lMczNEkRCj/0kXAEM4vFGN5pkR+U=";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out/share/plasma/plasmoids/dipzza.break-reminder
      cp -r "$src"/break-reminder-main/package/* "$out/share/plasma/plasmoids/dipzza.break-reminder/"
    '';
  };
  geometryChange = pkgs.stdenv.mkDerivation {
    pname = "Effect geometry change";
    version = "1.0";
    src = pkgs.fetchzip {
      url = "https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v1.5/kwin4_effect_geometry_change_1_5.tar.gz";
      sha256 = "sha256-1xjG6tIaUj97T2yHq+W7MLcODS0BN/yOzKgpql1/q1k=";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out/share/kwin/effects
      cp -r "$src"/* "$out/share/kwin/effects/"
    '';
  };
in {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../../theming
    ../../programs/default-apps
  ];

  theme = {
    enable = true;
    gtk = {
      enable = true;
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    qt.enable = false;
  };

  defaultApps = {
    imageViewerPackage = pkgs.kdePackages.gwenview;
    imageViewer = "org.kde.gwenview.desktop";
    documentViewerPackage = pkgs.kdePackages.okular;
    documentViewer = "org.kde.okular.desktop";
    mediaPlayerPackage = pkgs.haruna;
    mediaPlayer = "org.kde.haruna.desktop";
  };

  home.packages = with pkgs; [
    kdePackages.dolphin # File manager
    kdePackages.kamoso # Camera app
    kdePackages.kcalc # Calculator app
    kdePackages.kclock # Clock app
    kdePackages.ktorrent # Torrent app
    geometryChange # Geometry change kwin effect
    breakReminder # Break reminder widget
  ];

  # How to find needed settings
  ## 1. Check out this site to see if there is settings that you needed -
  ## https://nix-community.github.io/plasma-manager/options.xhtml
  # ----------------------------------------------------------------
  ## 2. If in the step before you couldn't managed to find what you needed, run this command in your terminal and paste in what you need -
  ## nix run github:nix-community/plasma-manager
  ## For example in Plasma Manager there is no way to declare notifications settings, you can change them using configFile
  # ----------------------------------------------------------------
  ## 3. If you want to configure widgets, at first configure them, and at second check this file and copy it in to here -
  ## .config/plasma-org.kde.plasma.desktop-appletsrc
  # ----------------------------------------------------------------

  programs.konsole = {
    enable = true;
    extraConfig = {
      "KonsoleWindow"."RememberWindowSize" = false;
    };
  };

  # Plasma Manager
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Default fonts
    # Small: Noto Sans 8pt
    # FixedWidth: Hack 10pt
    # Anything else: Noto Sans 10pt

    fonts = {
      fixedWidth = {
        family = fixedFont;
        pointSize = fixedFontSize;
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
      appearance.wallpaper = wallpaper;
    };

    shortcuts = {
      "services/zen.desktop" = {
        "_launch" = "Meta+Shift+F";
      };
      "services/org.telegram.desktop.desktop" = {
        "_launch" = "Meta+Shift+T";
      };
      "services/obsidian.desktop" = {
        "_launch" = "Meta+Shift+O";
      };
      "org.kde.konsole.desktop" = {
        "_launch" = "Meta+Shift+C";
      };
      kwin = {
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Window Maximize" = [ "Meta+PgUp" "Meta+M" ];
        "Window Quick Tile Bottom" = [ "Meta+Shift+J" "Meta+Down" ];
        "Window Quick Tile Left" = [ "Meta+Shift+H" "Meta+Left" ];
        "Window Quick Tile Right" = [ "Meta+Shift+L" "Meta+Right" ];
        "Window Quick Tile Top" = [ "Meta+Shift+K" "Meta+Up" ];
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
        "Switch to Next Desktop" = "Meta+Ctrl+L";
        "Switch to Previous Desktop" = "Meta+Ctrl+H";
        "Window to Next Desktop" = "Meta+Shift+Ctrl+L";
        "Window to Previous Desktop" = "Meta+Shift+Ctrl+H";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
      };
      ksmserver = {
        "Lock Session" = "Ctrl+Alt+L";
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
        repeatDelay = 250;
        repeatRate = 25;
      };
      mice = [
        {
          accelerationProfile = "none";
          name = "Compx 2.4G Wireless Receiver";
          vendorId = "25a7";
          productId = "fa7c";
        }
        {
          accelerationProfile = "none";
          name = "TPPS\\/2 IBM TrackPoint";
          vendorId = "0002";
          productId = "000a";
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
        blur.enable = true;
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

    #desktop.widgets = [
    #  {
    #    name = "org.kde.plasma.mediacontroller";
    #    position = {
    #      horizontal = 50;
    #      vertical = 100;
    #    };
    #    size = {
    #      height = 125;
    #      width = 125;
    #    };
    #  }
    #];

    panels = [
      {
        location = "bottom";
        height = 44;
        screen = 0;
        floating = false;
        # opacity = "translucent"; # one of “adaptive”, “opaque”, “translucent” # and it doesn't work
        widgets = [
          "org.kde.plasma.kickoff" # Default start menu
          "org.kde.plasma.pager" # Workspace switcher
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  # You can get the Applications running get-all-apps in terminal
                  "applications:systemsettings.desktop"
                  "applications:zen.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:discord.desktop"
                  "applications:obsidian.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
              };
            };
          }
          # "org.kde.plasma.mediacontroller" # media controller
          {
            name = "org.kde.plasma.weather";
            config = {
              Appearance = {
                showTemperatureInCompactMode = true;
              };
              Units = {
                pressureUnit = 5029;
                speedUnit = 9001;
                temperatureUnit = 6001;
                visibilityUnit = 2007;
              };
              WeatherStation = {
                source = "bbcukmet|weather|Almaty, Kazakhstan, KZ|1526384";
              };
            };
          }
          {
            name = "org.kde.plasma.notes";
            config = {
              General = {
                color = "translucent";
              };
            };
          }
          {
            name = "dipzza.break-reminder";
            config = {
              General = {
                focusMinutes = 10;
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
                "org.kde.plasma.weather"
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
        dimDisplay.idleTimeout = null;
        turnOffDisplay.idleTimeout = "never";
        powerProfile = "performance";
      };
      battery = {
        autoSuspend.action = "nothing";
        dimDisplay.idleTimeout = 300;
        turnOffDisplay.idleTimeout = 600;
        powerProfile = "balanced";
      };
    };

    startup = {
      startupScript = {
        "krunner".text = "krunner -d &";
      };
    };

    configFile = {
      "kdeglobals"."General" = {
        # TerminalApplication = "kitty";
        # TerminalService = "kitty.desktop";
        accentColorFromWallpaper = true;
      };
      "plasmanotifyrc"."Notifications" = {
        "PopupTimeout" = 1000;
      };
      "spectaclerc" = {
        "GuiConfig"."quitAfterSaveCopyExport" = true;
        "VideoSave"."preferredVideoFormat" = 2;
      };
      "kwinrc" = {
        "Plugins"."kwin4_effect_geometry_changeEnabled" = true;
        "TabBox"."LayoutName" = "big_icons";
      };
    };
  };
}
