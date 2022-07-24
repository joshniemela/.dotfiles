{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    username = "josh";
    homeDirectory = "/home/josh";
    stateVersion = "22.05";

    #file = {
    #  ".config/i3/config".source = ../../configs/i3;
    #  ".config/zsh/.p10k.zsh".source = "../../configs/p10k.zsh";
    #};
    #file.".config/zsh/.p10k.zsh" = {
    #  source = .dotfiles/configs/p10k;
    #};

    packages = with pkgs; [
      neofetch
      lxappearance
      flameshot
      arandr
      discord
      polymc
      pavucontrol
      thunderbird
      youtube-dl
      gimp
      viewnior
      libreoffice
      cmatrix
      easyeffects
   ];
  };

  programs = {
    texlive = { 
      enable = true; 
      #extraPackages = [];
    };
    mpv = { enable = true; };

    firefox = { enable = true; };

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
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
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
              #"${mod}+Shift+e" = "exec "" not done yet

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
                background =  "#2F343A";
                text =        "#FFFFFF";
                indicator =   "#190040";
                childBorder = "#402F62";
              };
            };
          };
        };
      };
    };
}
  
