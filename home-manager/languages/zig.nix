{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [zls zigpkgs.master];
}
