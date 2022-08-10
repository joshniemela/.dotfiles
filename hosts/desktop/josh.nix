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
      ".unison/default.prf".source  = ../../configs/unison.prf;
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
      dotnet-sdk_5
      hunspell
      hunspellDicts.en_GB-large
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;

    dunst = {
      enable = true;
      settings = import ../../modules/home-manager/dunst-purple.nix;
    };
  };
  imports = [
    ../../modules/home-manager/zsh.nix # enable zsh
    ../../modules/home-manager/git.nix # enable git
  ];
  programs = {
    sagemath.enable = true;
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
  
