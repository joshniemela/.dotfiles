{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home.username = "josh";
  home.homeDirectory = "/home/josh";

  home.packages = with pkgs; [
    git
    neofetch
    htop
  ];
  
  home.file = {};
}

