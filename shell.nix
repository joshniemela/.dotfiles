# shell.nix
{ pkgs }:
(with pkgs; let
  my-python-packages = python-packages: with python-packages; [
    pandas
    scipy
    matplotlib
    pyarrow
    numpy
    sklearn
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
in
python-with-my-packages)
