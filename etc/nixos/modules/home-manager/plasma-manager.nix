{
  inputs,
  pkgs,
  config,
  ...
}: let
  #wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/nix.png";
  wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png";

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
    haruna # Media player
    kdePackages.kcalc # Calculator app
    kdePackages.kclock # Clock app
    kdePackages.xdg-desktop-portal-kde # Desktop portal
  ];

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

    hotkeys.commands = {
      launch-copy-script = {
        name = "Launch Copy Script";
        key = "Meta+Alt+G";
        command = ''kitty sh -c "bash /etc/nixos/scripts/copy.sh"'';
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
      kwin = {
        "Window Close" = "Meta+C";
        "Window Fullscreen" = "Meta+F";
        "Switch to Desktop 1" = "Meta+F1";
        "Switch to Desktop 2" = "Meta+F2";
        "Switch to Desktop 3" = "Meta+F3";
        "Window to Desktop 1" = "Meta+Shift+F1";
        "Window to Desktop 2" = "Meta+Shift+F2";
        "Window to Desktop 3" = "Meta+Shift+F3";
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
  };

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
      "video/mp4" = "org.kde.haruna.desktop";
      "audio/mp3" = "org.kde.haruna.desktop";
      "audio/wav" = "org.kde.haruna.desktop";
      "application/pdf" = "org.kde.okular.desktop";
    };
  };
}
