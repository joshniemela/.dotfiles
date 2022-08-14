{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
  julia-wrapper = pkgs.callPackage ../../pkgs/julia-wrapper { inherit julia; };
in
{
  fonts.fontconfig.enable = true;
  imports = [
    ../../modules/home-manager/zsh.nix # Enable zsh
    ../../modules/home-manager/git.nix # Enable git
    ../../modules/home-manager/i3.nix # Enable x and i3
    ../../modules/home-manager/dunst.nix # Enable dunst
    ../../modules/home-manager/code.nix # Enable code
    ];
    theme = {
      statusbar = "i3status-rs";
      primaryColour = "#A03020";
      secondaryColour = "#902424";
    };
  services.dunst.settings.urgency_normal = {
    frame_color = lib.mkForce "#A03020";
    background = lib.mkForce "#5F676A";
  };

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
      texlive.combined.scheme-full
      docker-compose
      darktable
      julia-wrapper
      dotnet-sdk_5
      font-awesome # Icons
      (nerdfonts.override{fonts = [ "FiraCode" "Meslo" ];}) # Powerline breaks without this
      subversion
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;
  };
  
  programs = {
    home-manager.enable = true;
    i3status-rust = {
      enable = true;
      bars = {
        default = import ../../modules/home-manager/i3-rust-blocks.nix;
      };
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
      profiles = import ../../modules/home-manager/firefox.nix;
    };

    alacritty = {
      enable = true;
    };
  };
  
  home.stateVersion = "22.05";

}
  
