{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 4;
      gaps_out = 8;
      border_size = 2;
      "col.active_border" = "rgb(b4befe)";
      "col.inactive_border" = "rgb(6c7086)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 4;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = true;
        range = 3;
        render_power = 3;
        sharp = false;
        color = "rgba(0, 0, 0, 1)";
        offset = "0 0";
      };

      blur = {
        enabled = false;
        size = 6; # Default - 3
        passes = 2; # Will increase GPU usage, default - 1
        xray = true;
        noise = 0.08;
        contrast = 1;
        vibrancy = 0.1696;
        new_optimizations = true;
        ignore_opacity = true;
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master.new_status = "master";

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
    };
  };
}
