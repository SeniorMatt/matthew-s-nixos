{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 2;
      "col.active_border" = "rgb(999999)";
      "col.inactive_border" = "rgb(595959)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 0;
      rounding_power = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      shadow.enabled = false;
      blur.enabled = false;
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
