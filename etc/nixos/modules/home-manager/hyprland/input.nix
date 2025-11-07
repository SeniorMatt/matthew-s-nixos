{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us, ru";
      kb_variant = "";
      kb_model = "";
      kb_options = "grp:caps_toggle";
      kb_rules = "";
      follow_mouse = 1;
      sensitivity = 0;
      accel_profile = "adaptive";

      touchpad = {
        natural_scroll = true;
        disable_while_typing = false;
      };
    };
    cursor = {
      no_warps = false;
      warp_on_change_workspace = 1;
      warp_on_toggle_special = 0;
    };
    device = [
      {
        name = "compx-2.4g-dual-mode-mouse";
        accel_profile = "flat";
        #sensitivity = -0.25;
        sensitivity = 0.0;
      }
      {
        name = "compx-2.4g-wireless-receiver";
        accel_profile = "flat";
        #sensitivity = -0.25;
        sensitivity = 0.0;
      }
      {
        name = "tpps/2-elan-trackpoint";
        accel_profile = "flat";
        sensitivity = 0.0;
        scroll_factor = 0.25;
      }
    ];
  };
}
