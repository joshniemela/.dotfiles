{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    username = "josh";
    homeDirectory = "/home/josh";
    stateVersion = "22.05";

    file.".config/i3/config" = {
      source = ./configs/i3_config
    }
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
        source /home/josh/.config/zsh/.p10k.zsh
      '';
    };
  };
}
  
