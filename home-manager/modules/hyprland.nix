{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    grim
    slurp
    swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = "XCURSOR_SIZE,24";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = "5";
        gaps_out = "15";
        border_size = "1";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = "5";
        blur = "yes";
        blur_size = "3";
        blur_passes = "1";
        blur_new_optimizations = "on";

        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        # Selmer443 config
        # bezier = [
        #   "pace,0.46, 1, 0.29, 0.99"
        #   "overshot,0.13,0.99,0.29,1.1"
        #   "md3_decel, 0.05, 0.7, 0.1, 1"
        # ];
        # animation = [
        #   "windowsIn,1,6,md3_decel,slide"
        #   "windowsOut,1,6,md3_decel,slide"
        #   "windowsMove,1,6,md3_decel,slide"
        #   "fade,1,10,md3_decel"
        #   "workspaces,1,7,md3_decel,slide"
        #   "specialWorkspace,1,8,md3_decel,slide"
        #   "border,1,10,md3_decel"
        # ];

        #  PROxZima animations
        # bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
        # animation = [
        #   "windows, 1, 4, overshot, slide"
        #   "border, 1, 10, default"
        #   "fade, 1, 10, default"
        #   "workspaces, 1, 6, overshot, slidevert"
        # ];

        #  Caue's config
        bezier = [
          "in, 0.5, 1.2, 0.4, 1"
          "wss, 0.5, 1.15, 0.4, 1"
          "fader, 0.33, 1, 0.68, 1"
          "out, 0, 1, 0.6, 1"
        ];
        animation = [
          "windows, 1, 4, in"
          "border, 1, 10, default"
          "fade, 1, 7, fader"
          "workspaces, 1, 5, wss, slide"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
          preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = "true";
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      "device:epic-mouse-v1" = {
        sensitivity = "-0.5";
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
        "$mod, RETURN, exec, foot"
        "$mod, Q, killactive," 
        "$mod, M, exit,"
        "$mod, E, exec, nautilus"
        "$mod, V, togglefloating," 
        "$mod, R, exec, wofi --show drun"
        "$mod, P, pseudo," # dwindle
        "$mod, J, togglesplit," # dwindle

        # Screen-shot
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move window
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      exec = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };

  programs.wofi = {
    enable = true;
  };
}
