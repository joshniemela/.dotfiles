{ pkgs, ... }:
{

  home.packages = with pkgs; [
    nodePackages.pyright
    #tree-sitter
  ];
}
