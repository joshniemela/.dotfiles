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
      pavucontrol
      thunderbird
      youtube-dl
      gimp
      viewnior
      libreoffice
      unison
      tree
      texlive.combined.scheme-full # Make this smaller in the future, I don't need the entire texlive enviroment
      docker-compose
      darktable
      julia-wrapper
      dotnet-sdk_5
      hunspell
      hunspellDicts.en_GB-large # Dictionary for hunspell
      xournalpp # Modfiying PDF docs for signing
      tiled
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;
  };
  imports = [
    ../../modules/home-manager/zsh.nix # Enable zsh
    ../../modules/home-manager/git.nix # Enable git
    ../../modules/home-manager/i3.nix # Enable x and i3
    ../../modules/home-manager/dunst.nix # Enable dunst
    ../../modules/home-manager/code.nix # Enable vscode and packages
  ];
  programs = {
#    sagemath.enable = true;
#    direnv = {
#      enable = true;
#      nix-direnv.enable = true;
#    };
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
  };
}
  
