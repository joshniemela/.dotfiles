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
    ../../modules/home-manager/i3.nix # enable x and i3
    ../../modules/home-manager/dunst.nix # Enable dunst
    ];
    theme = {
      statusbar = "i3status-rs";
      primaryColour = "#E03444";
      secondaryColour = "#902424";
    };
  services.dunst.settings.urgency_normal.background = lib.mkForce "#E03444";
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
    
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop # Latex
        bbenoist.nix # Nix 
        naumovs.color-highlight # Shows hex codes with colour
        pkief.material-icon-theme # Icon theme
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        { # Julia
          name = "language-julia"; 
          publisher = "julialang";
          version = "1.6.30";
          sha256 = "sha256-HZaltck0cKSBSPGCByLaIgui2tUf+aLmR56vyi60YUQ=";
        }
      ];
    };
  };
  
  home.stateVersion = "22.05";

}
  
