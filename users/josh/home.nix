{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
  julia-wrapper = pkgs.callPackage ../../pkgs/julia-wrapper { inherit julia; };
in 
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
      texlive.combined.scheme-full
      docker-compose
      darktable
      julia-wrapper
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;

    dunst = {
      enable = true;
      settings = import ../../modules/home-manager/dunst.nix;
    };
  };
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Joshua Niemelä";
      userEmail = "josh@jniemela.dk";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    autorandr = {
      enable = true;
      profiles = import ../../modules/home-manager/autorandr/desktop.nix;
    };

    mpv = { 
      enable = true; 
    };

    firefox = { 
      enable = true; 
      #profiles = ../../modules/home-manager/firefox.nix;
    };

    alacritty = {
      enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscode;
      #package = pkgs.vscodium;
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
        
        config = import ../../modules/home-manager/i3.nix { 
          inherit pkgs; 
          mod = "Mod1"; # Set to Mod1 for alt, Mod4 for super
        };
      };
    };
  };
  home.stateVersion = "22.05";
}
  
