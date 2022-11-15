{ config, pkgs, pkgs-stable, ... }:
{
  
  imports = [
    ../../modules/home-manager/zsh.nix # Enable zsh
    ../../modules/home-manager/git.nix # Enable git
    #../../modules/home-manager/xmonad/xmonad.nix # Enable x and xmonad
    ../../modules/home-manager/i3.nix # Enable x and xmonad
    ../../modules/home-manager/dunst.nix # Enable dunst
    ../../modules/home-manager/code.nix # Enable vscode and packages
    ../../modules/home-manager/defaultpkgs.nix # Packages across laptop and desktop
    ../../modules/julia/default.nix
    ../../modules/fsharp.nix
  ];
  
  home = {
    packages = with pkgs; [
      font-awesome # Iconscode 
      (nerdfonts.override{fonts = [ "FiraCode" "Meslo" ];}) # Powerline breaks without this
      dmenu
      conda
   ];
  };
  services = {
    easyeffects.enable = true;
  };
  
  programs = {
    home-manager.enable = true;
    autorandr = {
      enable = true;
      profiles = import ../../modules/home-manager/autorandr/desktop.nix;
    };

    firefox = { 
      enable = true; 
      #profiles = ../../modules/home-manager/firefox.nix;
    };
  };
  home.stateVersion = "22.05";
}
  
