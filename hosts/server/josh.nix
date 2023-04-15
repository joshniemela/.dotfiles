{
  config,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
in {
  programs = {
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
