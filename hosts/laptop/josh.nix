{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
  julia-wrapper = pkgs.callPackage ../../pkgs/julia-wrapper { inherit julia; };
in 
{
  fonts.fontconfig.enable = true;
  imports = [
    ../../modules/home-manager/zsh.nix # enables zsh
    ../../modules/home-manager/git.nix # enable git
    ];
  home = {
    file = {
      ".unison/default.prf".source  = ../../configs/default.prf;
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
      font-awesome #icons
      (nerdfonts.override{fonts = [ "FiraCode" "Meslo" ];})
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
    home-manager.enable = true;
    i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "networkmanager";
              on_click = "alacritty -e nmtui";
              ap_format = "{ssid^10}";
            }
            {
              block = "disk_space";
              path = "/";
              alias = "/";
              info_type = "available";
              unit = "GB";
              interval = 60;
              warning = 20.0;
              alert = 10.0;
            }
            {
              block = "memory";
              format_mem = "{mem_avail}";
              format_swap = "{swap_avail}";
            }
            {
              block = "cpu";
              interval = 1;
	            format="{barchart}";
            }
            { block = "sound"; }
            {
              block = "battery";
              interval = 15;
              format = "{percentage} {time}";
            }
            {
              block = "weather";
              format = "{weather} {temp}C {humidity}% {wind}m/s {direction}";
              service = {
                name = "openweathermap"; 
                api_key = "75913c9c48b7fcab3d9d9cae7c9dac7a";
                city_id = "2618425";
                units = "metric";
              };
            }
            {
              block = "time";
              interval = 60;
              format = "%a %d/%m %R";
              on_click = "thunderbird -calendar";
            }
          ];
          #settings = {
          #  theme =  {
          #    name = "solarized-dark";
          #    overrides = {
          #      idle_bg = "#123456";
          #      idle_fg = "#abcdef";
          #    };
          #  };
          #};
          icons = "awesome6";
          theme = "solarized-dark";
        };
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
        
        config = import ../../modules/home-manager/i3-rust.nix { 
          inherit pkgs; 
          mod = "Mod1"; # Set to Mod1 for alt, Mod4 for super
       };
     };
    };
  };
  home.stateVersion = "22.05";
}
  
