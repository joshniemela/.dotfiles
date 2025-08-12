{ pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      animations.enabled = "no";
      "$mainMod" = "ALT";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "fuzzel -b 202020EE -t 928374FF -m D1632BFF -s 3C3836FF -C D1632BFF -M EE8844FF -r 0";

      monitor = ",highres,auto,1";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod SHIFT, R, exec, $HOME/.config/hypr/script/fuzzel_pass.sh $menu"

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
        "$mainMod SHIFT, n, exec, kitty -e testSystem"
        "$mainMod SHIFT, m, exec, kitty --hold=no -e switchSystem"

        ", PRINT, exec, hyprshot -m region"
        "$mainMod, PRINT, exec, hyprshot -m window"
      ];

      binde = [
        # Move focus
        "$mainMod, h, resizeactive, -20 0"
        "$mainMod, j, layoutmsg, cycleprev"
        "$mainMod, k, layoutmsg, cyclenext"
        "$mainMod, l, resizeactive, 20 0"
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

        "workspace 2, class:^(Vivaldi-stable)$"

        # The remmina client goes to 10, any windows it opens go to 5
        "workspace 10, class:^(org\.remmina\.Remmina)$, title: ^Remmina Remote Desktop Client$"
        "workspace 6, class:^(org\.remmina\.Remmina)$, title: negative:^Remmina Remote Desktop Client$"
        "workspace 10, class:^\.virt-manager-wrapped$, title: ^Virtual Machine Manager$"
        "workspace 5, class:^\.virt-manager-wrapped$, title: .*QEMU/KVM$"
      ];

      exec-once = [
        "vivaldi"
        "virt-manager"
        "remmina"
      ];

      general = {
        layout = "master";
        border_size = 2;
        gaps_in = 2;
        gaps_out = 0;

        "col.active_border" = "rgba(D1632BEE) rgba(402F65EE) 45deg";
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
  programs = {
    kitty.enable = true;
    fuzzel.enable = true;

    waybar = {
      enable = true;
      systemd.enable = true;

      settings = [
        {
          height = 26;
          layer = "top";
          position = "bottom";
          tray = {
            spacing = 10;
          };

          modules-left = [
            "custom/server_ping"
          ];
          modules-center = [
            "memory"
            "disk"
            "battery"
          ];
          modules-right = [
            "custom/weather"
            "clock"
          ];

          battery = {
            format = "{icon} {capacity}%";
            format-alt = "{icon} {time}";
            format-charging = " {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            format-plugged = " {capacity}%";
            states = {
              critical = 15;
              warning = 30;
            };
          };

          clock = {
            interval = 1;
            format = "Week {:%V %F (%a) %T}";
            tooltip = false;
          };

          memory = {
            interval = 10;
            format = "  {used:0.1f}/{total:0.1f}GiB";
          };

          disk = {
            interval = 10;
            format = " {specific_used:0.1f}/{specific_used:0.1f}GiB";
            unit = "GiB";
          };

          "custom/server_ping" = {
            format = "  jniemela.dk {}";
            interval = 10;
            on-click = "kitty -e ssh jniemela.dk";
            exec = "/home/josh/.config/waybar/script/server_ping.sh";
            return-type = "json";
          };

          "custom/weather" = {
            format = "{}";
            interval = 120;
            exec = "/home/josh/.config/waybar/script/weather.sh";
            return-type = "json";
          };
        }
      ];

      style =
        ''
          widget > * {
            margin: 0 8px 0 8px;
          }

          #custom-weather {
            background-repeat: no-repeat;
            background-position: 0% 50%;
            background-size: 28px 28px;
            padding-left: 28px;
          }

          .up {
            color: #00FF00;
          }
          .down {
            color: #FF0000;
          }
        ''
        + builtins.readFile ./weather-icons.css;
    };
  };
  home = {
    # Hint Electron apps to use Wayland:
    sessionVariables.NIXOS_OZONE_WL = "1";
    packages = with pkgs; [
      hyprshot
    ];
    file = {

      ".config/waybar/script/server_ping.sh" = {
        text = ''
          #!/bin/sh

          if ping -c 1 -W 1 jniemela.dk >/dev/null; then
              printf '{"text":"","class":"up"}'
          else
              printf '{"text":"","class":"down"}'
          fi
        '';
        executable = true;
      };

      ".config/waybar/script/weather.sh" = {
        text = ''
          response=$(curl -s \
            -H "User-Agent: myweatherapp/1.0 you@example.com" \
            "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=55.6761&lon=12.5683")

          symbol_code=$(echo "$response" | jq -r '.properties.timeseries[0].data.next_1_hours.summary.symbol_code')
          temp=$(echo "$response" | jq -r '.properties.timeseries[0].data.instant.details.air_temperature')
          humidity=$(echo "$response" | jq -r '.properties.timeseries[0].data.instant.details.relative_humidity')

          pressure_raw=$(echo "$response" | jq -r '.properties.timeseries[0].data.instant.details.air_pressure_at_sea_level')
          pressure=$(echo "$pressure_raw" | awk '{printf "%d\n", $1 + 0.5}')

          printf '{"text":"%s°C, %s%%, %shPa","class":"%s"}\n' "$temp" "$humidity" "$pressure" "$symbol_code"
        '';
        executable = true;
      };
      ".config/hypr/script/fuzzel_pass.sh" = {
        text = ''
          menu_cmd="$1"

          shopt -s nullglob globstar

          prefix=$HOME/.password-store
          password_files=("$prefix"/**/*.gpg)
          password_files=("''${password_files[@]#"$prefix"/}")
          password_files=("''${password_files[@]%.gpg}")

          password=$(printf '%s\n' "''${password_files[@]}" | $menu_cmd --dmenu "$@")

          [[ -n $password ]] || exit

          pass show -c "$password" 2>/dev/null

        '';
        executable = true;
      };
    };
  };
}
