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
      texlive.combined.scheme-full # Make this smaller in the future, I don't need the entire texlive enviroment
      docker-compose
      darktable
      julia-wrapper
      dotnet-sdk_5
      hunspell
      hunspellDicts.en_GB-large # Dictionary for hunspell
      xournalpp # Modfiying PDF docs for signing
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;
  };
  imports = [
    ../../modules/home-manager/zsh.nix # enable zsh
    ../../modules/home-manager/git.nix # enable git
    ../../modules/home-manager/i3.nix # enable x and i3
    ../../modules/home-manager/dunst.nix # enable dunst
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
      extensions = with pkgs.vscode-extensions; [ # All the packages available in Nix
        james-yu.latex-workshop # Latex
        bbenoist.nix # Nix 
        naumovs.color-highlight # Shows hex codes with colour
        pkief.material-icon-theme # Icon theme
        ionide.ionide-fsharp # F# IDE
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ # All the packages not available in Nix
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
  
