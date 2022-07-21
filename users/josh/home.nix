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
  programs.vscode = {
  enable = true;
  package = pkgs.vscodium;
  extensions = with pkgs.vscode-extensions; [
    vscode-extensions.james-yu.latex-workshop
    vscode-extensions.bbenoist.nix
    vscode-extensions.julialang.julia
  ];
};
  home.file = {};
}

