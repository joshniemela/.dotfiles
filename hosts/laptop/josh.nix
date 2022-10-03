{ config, pkgs, lib, ... }:
{
  fonts.fontconfig.enable = true;
  imports = [
    ../../modules/home-manager/zsh.nix # Enable zsh
    ../../modules/home-manager/git.nix # Enable git
    ../../modules/home-manager/i3.nix # Enable x and i3
    ../../modules/home-manager/dunst.nix # Enable dunst
    ../../modules/home-manager/code.nix # Enable code
    ../../modules/home-manager/defaultpkgs.nix # Packages across laptop and desktop
    ../../modules/julia/default.nix # Julia
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
      font-awesome # Icons
      (nerdfonts.override{fonts = [ "FiraCode" "Meslo" ];}) # Powerline breaks without this
      brightnessctl # Brightness control
   ];
  };
  
  programs = {
    autorandr = {
      enable = true;
      profiles = import ../../modules/home-manager/autorandr/laptop.nix;
    };
    home-manager.enable = true;

    i3status-rust = {
      enable = true;
      bars = {
        default = import ../../modules/home-manager/i3-rust-blocks.nix;
      };
    };

    firefox = { 
      enable = true; 
      profiles = import ../../modules/home-manager/firefox.nix;
    };
  };
  home.stateVersion = "22.05";
}
  
