{
  inputs,
  pkgs,
  config,
  ...
}: let
  #wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png";
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/catppuccin/the_creation_of_adam_catppuccin.png";

  cursorName = "breeze_cursors";
  cursor = pkgs.kdePackages.breeze;

  gtkName = "Breeze-Dark";
  gtkTheme = pkgs.kdePackages.breeze-gtk;

  generalFont = "Noto Sans";
  fixedFont = "JetBrainsMono";
  generalFontSize = 12;
  smallFontSize = 10;
in {
  imports = [inputs.plasma-manager.homeModules.plasma-manager];

  home.packages = with pkgs; [
    mpv # Media player
    kdePackages.kcalc # Calculator app
    kdePackages.kclock # Clock app
    kdePackages.xdg-desktop-portal-kde # Desktop portal
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
        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Window to Desktop 6" = "Meta+Shift+6";
        "Window to Desktop 7" = "Meta+Shift+7";
        "Window to Desktop 8" = "Meta+Shift+8";
        "Window to Desktop 9" = "Meta+Shift+9";
        "Window to Desktop 10" = "Meta+Shift+0";
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
        #repeatDelay = 250;
        #repeatRate = 40;
      };
      #mice = [
      #{
      #accelerationProfile = "none";
      #name = "name";
      #productId = "00c1";
      #vendorId = "1532";
      #}
      #];
      touchpads = [
        {
          disableWhileTyping = false;
          enable = true;
          naturalScroll = true;
          pointerSpeed = 0;
          tapToClick = true;

          name = "Synaptics TM3276-022";
          productId = "0000";
          vendorId = "06cb";
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

    panels = [
      {
        location = "bottom";
        height = 44;
        screen = 0;
        floating = true;
        widgets = [
          "org.kde.plasma.kickoff" # start menu
          "org.kde.plasma.pager" # workspace switcher
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

  # GTK theme
  gtk = {
    enable = true;

    theme = {
      name = gtkName;
      package = gtkTheme;
    };

    font = {
      name = generalFont;
      size = generalFontSize;
    };
  };

  # Setting mouse cursor
  home.file.".icons/default".source = "${cursor}/share/icons/${cursorName}";

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
