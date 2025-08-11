{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      animations.enabled = "no";
      "$mainMod" = "ALT";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "fuzzel";

      monitor = ",highres,auto,1";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"

        # Scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        "$mainMod, W, layoutmsg, swapwithmaster"

        # NixOS build keybinds
        "$mainMod SHIFT, s, exec, kitty --hold=no -e switchSystem"
        "$mainMod SHIFT, t, exec, kitty -e testSystem"
      ];

      binde = [
        # Move focus
        "$mainMod, h, resizeactive, 20 0"
        "$mainMod, j, layoutmsg, cycleprev"
        "$mainMod, k, layoutmsg, cyclenext"
        "$mainMod, l, resizeactive, -20 0"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 15%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 15%-"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      general = {
        layout = "master";
        border_size = 2;
        gaps_in = 2;
        gaps_out = 0;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;
      };

      input = {
        kb_layout = "dk";

        follow_mouse = 1;
        repeat_delay = 220;
        repeat_rate = 25;

        sensitivity = 0.5;
      };

    };
  };
  # Hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  programs = {
    kitty.enable = true;
    fuzzel.enable = true;

    waybar = {
      enable = true;
      systemd.enable = true;

      settings = [
        {
          height = 20;
          layer = "top";
          position = "bottom";
          tray = {
            spacing = 10;
          };

          modules-left = [ ];
          modules-center = [ ];
          modules-right = [
            "battery"
            "clock"
          ];

          battery = {
            format = "{capacity}% {icon}";
            format-alt = "{time} {icon}";
            format-charging = "{capacity}% ";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            format-plugged = "{capacity}% ";
            states = {
              critical = 15;
              warning = 30;
            };
          };

          clock = {
            format = "Week {:%V %F (%a) %T}";
            tooltip = false;
          };
        }
      ];
    };
  };
}
