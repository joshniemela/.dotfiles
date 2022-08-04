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
    ../../modules/home-manager/zsh.nix #enables zsh
  ];
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
    
    alacritty = {
      enable = true;
    };  
  };
  home.stateVersion = "22.05";
}
  
