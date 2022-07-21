{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    username = "josh";
    homeDirectory = "/home/josh";
    stateVersion = "22.05";
    packages = with pkgs; [
      git
      neofetch
      htop
      lxappearance
      flameshot
      firefox
      mpv
      arandr
      discord
      polymc
      pavucontrol
      alacritty
      thunderbird
      youtube-dl
      gimp
      viewnior
   ];
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      james-yu.latex-workshop
      bbenoist.nix
      #julialang.julia
    ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
  };
  
}
  
