{ config, pkgs, ... }:

let
  lib = pkgs.lib;
in 
{
  programs.home-manager.enable = true;
  home = {
    #packages = with pkgs; [
    #  
    #];
  };

  imports = [
    ../../modules/home-manager/zsh.nix # enable zsh
    ../../modules/home-manager/git.nix # enable git
  ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    
    alacritty = {
      enable = true;
    };  
  };
  home.stateVersion = "22.05";
}
  
