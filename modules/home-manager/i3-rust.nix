{pkgs, mod, ...}:
{
  modifier = mod; # Use alt instead of super
  defaultWorkspace = "workspace number 1";


  # Resize mode
  modes.resize = {
    Left   = "resize shrink width 10 px or 1 ppt";
    Down   = "resize grow height 10 px or 1 ppt";
    Up     = "resize shrink height 10 px or 1 ppt";
    Right  = "resize grow width 10 px or 1 ppt";
    Escape = "mode default";
    Return = "mode default";
    "${mod}+r" = "mode default";
  };

  keybindings = {
    # Lauch dmenu
    "${mod}+d" = ''exec --no-startup-id "dmenu_run -sb '#E03444'"'';
    # Kill window
    "${mod}+Shift+q" = "kill";
    # Open terminal 
    "${mod}+Return" = "exec alacritty";
    # Open flameshot
    Print = "exec flameshot gui";

    # Change focus
    "${mod}+Left" = "focus left";
    "${mod}+Down" = "focus down";
    "${mod}+Up" = "focus up";
    "${mod}+Right" = "focus right";

    # Move window
    "${mod}+Shift+Left" = "move left";
    "${mod}+Shift+Down" = "move down";
    "${mod}+Shift+Up" = "move up";
    "${mod}+Shift+Right" = "move right";

    # Split & fullscren
    "${mod}+h" = "split h";
    "${mod}+v" = "split v";
    "${mod}+f" = "fullscreen toggle";

    # Change layout
    "${mod}+s" = "layout stacking";
    "${mod}+w" = "layout tabbed";
    "${mod}+e" = "layout toggle split";

    # Toggle tiling / floating
    "${mod}+Shift+shift" = "floating toggle";

    # Change focus between tiling / floating
    "${mod}+Shift+space" = "mode_toggle"; 

    # Focus parent
    "${mod}+a" = "focus parent";

    # Focus child
    #"${mod}+d" = "focus child"; current keybinding overlaps with dmenu launch

    # Switch to workspace
    "${mod}+1" = "workspace number 1";
    "${mod}+2" = "workspace number 2";
    "${mod}+3" = "workspace number 3";
    "${mod}+4" = "workspace number 4";
    "${mod}+5" = "workspace number 5";
    "${mod}+6" = "workspace number 6";
    "${mod}+7" = "workspace number 7";
    "${mod}+8" = "workspace number 8";
    "${mod}+9" = "workspace number 9";
    "${mod}+0" = "workspace number 10";

    # Move focused to workspace
    "${mod}+Shift+1" = "move container to workspace number 1";
    "${mod}+Shift+2" = "move container to workspace number 2";
    "${mod}+Shift+3" = "move container to workspace number 3";
    "${mod}+Shift+4" = "move container to workspace number 4";
    "${mod}+Shift+5" = "move container to workspace number 5";
    "${mod}+Shift+6" = "move container to workspace number 6";
    "${mod}+Shift+7" = "move container to workspace number 7";
    "${mod}+Shift+8" = "move container to workspace number 8";
    "${mod}+Shift+9" = "move container to workspace number 9";
    "${mod}+Shift+0" = "move container to workspace number 10";

    # Reload i3 config
    "${mod}+Shift+c" = "reload";

    # Restart i3
    "${mod}+Shift+r" = "restart";

    # Exit i3 
    "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'Exit i3?' -B 'Yes, exit i3' 'i3-msg exit'"'';

    # Enter resize mode
    "${mod}+r" = "mode resize";


  };

  bars = [{
    #fonts = {
    #names = [ "Font Awesome 6 Brands"]; # "Sans Mono" "DejaVu"];
    #size = 11.0;
    #};
    statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml"; #-c ~/.config/i3status-rust/bottom-config.toml;
   # i3status colors
    colors = {
      background = "#000000";
      statusline = "#FFFFFF";
      separator = "#666666";
      
      focusedWorkspace = {
        border = "#E03444";
        background = "#2F343A";
        text = "#FFFFFF";
      };
      activeWorkspace = {
        border = "#333333";
        background = "#5F676A";
        text = "#FFFFFF";
      };
      inactiveWorkspace = {
        border = "#333333";
        background = "#222222";
        text = "#888888";
      };
      urgentWorkspace = {
        border = "#2F343A";
        background = "#F0D000";
        text = "#FFFFFF";
      };
      bindingMode = {
        border = "#2F343A";
        background = "#F0D000";
        text = "#FFFFFF";
      };
    };
  }];
  # i3 colors


  fonts = {
    names = [ "DejaVu Sans Mono" "Font Awesome 6 Brands" ];
    style = "Bold Semi-Condensed";
    size = 11.0;
  };
  colors = {
    focused = {
      border =      "#E03444";
      background =  "#E03444";
      text =        "#FFFFFF";
      indicator =   "#902424";
      childBorder = "#E03444";
    };
  };
}
