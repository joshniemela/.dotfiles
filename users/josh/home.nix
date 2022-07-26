{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    file = {
      ".unison/default.prf".source  = ../../configs/default.prf;
    };
    packages = with pkgs; [
      neofetch
      lxappearance
      discord
      polymc
      pavucontrol
      thunderbird
      youtube-dl
      gimp
      viewnior
      libreoffice
      unison
      tree
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;

    dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#5F676A";
          font = "Droid Sans 9";
          separator_height = 2;
          padding = 8;
          frame_width = 3;
        };

        urgency_low = {
          background = "#222222";
          foreground = "#888888";
          timeout = 10;
        };
        urgency_normal = {
          background = "#402F65";
          foreground = "#FFFFFF";
          frame_color = "#5F676A";
          timeout = 10;
        };
        urgency_criticall = {
          background = "#900000";
          foreground = "#FFFFFF";
          frame_color = "#FF0000";
          timeout = 0;
        };
      };  

    };
  };
  programs = {
    autorandr = {
      enable = true;
      profiles = {
        "desktop" = {
          fingerprint = {
            DVI-D-0 = "00ffffffffffff0004720e0464883060031a010380351e782a0ef5a555509e26105054b30c00714f818081c081009500b300d1c00101023a801871382d40582c4500132b2100001e000000fd00374c1e5311000a202020202020000000ff0054314d4545303034343230300a000000fc0041636572204b323432484c0a200097";
            HDMI-0 = "00ffffffffffff0005e37024e95c0000071b010380341d782a2ac5a4564f9e280f5054bfef00d1c0b30095008180814081c001010101023a801871382d40582c450009252100001e000000fd00324c1e5311000a202020202020000000fc0032343730570a20202020202020000000ff0047474a48324841303233373835016802031ef14b101f051404130312021101230907078301000065030c0010008c0ad08a20e02d10103e9600092521000018011d007251d01e206e28550009252100001e8c0ad08a20e02d10103e96000925210000188c0ad090204031200c405500092521000018023a801871382d40582c450009252100001e00000000000000d1";
            HDMI-1 = "00ffffffffffff005a632238010101011013010380341d782eeed5a555489b26125054bfef80d1c0b300a9409500904081808140714f023a801871382d40582c450008222100001e000000ff005234463039313630333138330a000000fd00324b0f5212000a202020202020000000fc00565832343333776d0a202020200133020325f152900504030207060f0e1f141e1d1312111601230907078301000065030c001000023a801871382d40582c450008222100001e011d8018711c1620582c250008222100009e011d007251d01e206e28550008222100001e023a80d072382d40102c458008222100001e8c0ad08a20e02d10103e9600082221000018e3";
          };
          config = {
            HDMI-1 = {
              enable = true;
            };
          };
        };
      };
     
    };
    texlive = { 
      enable = true; 
      #extraPackages = [];
    };
    mpv = { 
      enable = true; 
    };

    firefox = { 
      enable = true; 
    };

    alacritty = {
      enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop
        bbenoist.nix
        #julialang.julia need to figure out how to add this thing with vs marketplace
      ];
    };

    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      
      zplug = {
        enable = true;
        plugins = [
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
      shellAliases = {
        ll = "ls -l";
        lag = "ls -ag";
        applySystem = "source ~/.dotfiles/apply-system.sh";
        dir="dir --color='auto'";
        grep="grep --color='auto'";
        unison="unison -ui text";
      };
      initExtra = ''
        bindkey "^[[H" beginning-of-line
        bindkey "^[[F" end-of-line
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        source .dotfiles/./configs/p10k.zsh
      '';
    };
    
  };
  xsession = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
          config = let mod = "Mod1"; in {
            modifier = mod;
            defaultWorkspace = "workspace number 1";


            #resize mode
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
              "${mod}+d" = ''exec --no-startup-id "dmenu_run -sb '#402F65'"'';
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
              statusCommand = "${pkgs.i3status}/bin/i3status";
              # i3status colors
              colors = {
                background = "#000000";
                statusline = "#FFFFFF";
                separator = "#666666";
                
                focusedWorkspace = {
                  border = "#402F65";
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
                  background = "#900000";
                  text = "#FFFFFF";
                };
                bindingMode = {
                  border = "#2F343A";
                  background = "#900000";
                  text = "#FFFFFF";
                };
              };
            }];
            # i3 colors
            colors = {
              focused = {
                border =      "#402F65";
                background =  "#402F65";
                text =        "#FFFFFF";
                indicator =   "#190040";
                childBorder = "#402F62";
              };
            };
          };
        };
      };
    };

    home.stateVersion = "22.05";
}
  
