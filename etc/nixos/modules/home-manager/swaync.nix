{pkgs, ...}: {
  home.packages = with pkgs; [
    swaynotificationcenter # Notification manager
    libnotify # notify-send command
  ];

  services.swaync = {
    enable = true;
    settings = {
      # 1) Allow GTK_THEME / global theming to affect swaync again
      # "ignore-gtk-theme" = false;
    };
  };

  xdg.configFile = {
    "swaync/style.css".text = ''
      * {
        all: unset;
        font-size: 12px;
        font-family: "JetBrains Mono";
        transition: 200ms;
      }

      trough highlight {
        background: #cdd6f4;
      }

      scale {
        margin: 0 7px;
      }

      scale trough {
        margin: 0rem 1rem;
        min-height: 8px;
        min-width: 70px;
        border-radius: 12.6px;
      }

      trough slider {
        margin: -10px;
        border-radius: 12.6px;
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
        transition: all 0.2s ease;
        background-color: #89b4fa;
      }

      trough slider:hover {
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.8), 0 0 8px #89b4fa;
      }

      trough {
        background-color: #313244;
      }

      /* notifications */
      .notification-background {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #45475a;
        border-radius: 12.6px;
        margin: 18px;
        background: #181825;
        color: #cdd6f4;
        padding: 0;
      }

      .notification-background .notification {
        padding: 7px;
        border-radius: 12.6px;
      }

      .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 #f38ba8;
      }

      .notification .notification-content {
        margin: 7px;
      }

      .notification .notification-content overlay {
        /* icons */
        margin: 4px;
      }

      .notification-content .summary {
        color: #cdd6f4;
      }

      .notification-content .time {
        color: #a6adc8;
      }

      .notification-content .body {
        color: #bac2de;
      }

      .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        color: #1e1e2e;
        background-color: #f38ba8;
      }

      .notification-background .close-button:hover {
        background-color: #eba0ac;
      }

      .notification-background .close-button:active {
        background-color: #f5c2e7;
      }

      .notification .notification-action {
        border-radius: 7px;
        color: #cdd6f4;
        box-shadow: inset 0 0 0 1px #45475a;
        margin: 4px;
        padding: 8px;
        font-size: 0.2rem; /* controls the button size not text size*/
      }

      .notification .notification-action {
        background-color: #313244;
      }

      .notification .notification-action:hover {
        background-color: #45475a;
      }

      .notification .notification-action:active {
        background-color: #585b70;
      }

      .notification.critical progress {
        background-color: #f38ba8;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: #89b4fa;
      }

      .notification progress,
      .notification trough,
      .notification progressbar {
        border-radius: 12.6px;
        padding: 3px 0;
      }

      /* control center */
      .control-center {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #313244;
        border-radius: 12.6px;
        background-color: #1e1e2e;
        color: #cdd6f4;
        padding: 14px;
      }

      .control-center .notification-background {
        border-radius: 7px;
        box-shadow: inset 0 0 0 1px #45475a;
        margin: 4px 10px;
      }

      .control-center .notification-background .notification {
        border-radius: 7px;
      }

      .control-center .notification-background .notification.low {
        opacity: 0.8;
      }

      .control-center .widget-title > label {
        color: #cdd6f4;
        font-size: 1.3em;
      }

      .control-center .widget-title button {
        border-radius: 7px;
        color: #cdd6f4;
        background-color: #313244;
        box-shadow: inset 0 0 0 1px #45475a;
        padding: 8px;
      }

      .control-center .widget-title button:hover {
        background-color: #45475a;
      }

      .control-center .widget-title button:active {
        background-color: #585b70;
      }

      .control-center .notification-group {
        margin-top: 10px;
      }

      .control-center .notification-group:focus .notification-background {
        background-color: #313244;
      }

      scrollbar slider {
        margin: -3px;
        opacity: 0.8;
      }

      scrollbar trough {
        margin: 2px 0;
      }

      /* dnd */
      .widget-dnd {
        margin-top: 5px;
        border-radius: 8px;
        font-size: 1.1rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 8px;
        background: #313244;
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background: #89b4fa;
      }

      .widget-dnd > switch slider {
        background: #45475a;
        border-radius: 8px;
      }

      /* mpris */
      .widget-mpris-player {
        background: #313244;
        border-radius: 12.6px;
        color: #cdd6f4;
      }

      .mpris-overlay {
        background-color: #313244;
        opacity: 0.9;
        padding: 15px 10px;
      }

      .widget-mpris-album-art {
        -gtk-icon-size: 100px;
        border-radius: 12.6px;
        margin: 0 10px;
      }

      .widget-mpris-title {
        font-size: 1.2rem;
        color: #cdd6f4;
      }

      .widget-mpris-subtitle {
        font-size: 1rem;
        color: #bac2de;
      }

      .widget-mpris button {
        border-radius: 12.6px;
        color: #cdd6f4;
        margin: 0 5px;
        padding: 2px;
      }

      .widget-mpris button image {
        -gtk-icon-size: 1.8rem;
      }

      .widget-mpris button:hover {
        background-color: #313244;
      }

      .widget-mpris button:active {
        background-color: #45475a;
      }

      .widget-mpris button:disabled {
        opacity: 0.5;
      }

      .widget-menubar > box > .menu-button-bar > button > label {
        font-size: 3rem;
        padding: 0.5rem 2rem;
      }

      .widget-menubar > box > .menu-button-bar > :last-child {
        color: #f38ba8;
      }

      .power-buttons button:hover,
      .powermode-buttons button:hover,
      .screenshot-buttons button:hover {
        background: #313244;
      }

      .control-center .widget-label > label {
        color: #cdd6f4;
        font-size: 2rem;
      }

      .widget-buttons-grid {
        padding-top: 1rem;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button label {
        font-size: 2.5rem;
      }

      .widget-volume {
        padding: 1rem 0;
      }

      .widget-volume label {
        color: #74c7ec;
        padding: 0 1rem;
      }

      .widget-volume trough highlight {
        background: #74c7ec;
      }

      .widget-backlight trough highlight {
        background: #f9e2af;
      }

      .widget-backlight label {
        font-size: 1.5rem;
        color: #f9e2af;
      }

      .widget-backlight .KB {
        padding-bottom: 1rem;
      }

      .image {
        padding-right: 0.5rem;
      }
    '';
  };
}
