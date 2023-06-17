{
  config,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
in {
  programs.home-manager.enable = true;
  home = {
    packages = with pkgs; [
      neofetch
      htop
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zsh.enable = true;
    alacritty = {
      enable = true;
    };
  };
  home.stateVersion = "22.05";
}
