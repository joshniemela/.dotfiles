{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkg.zls zigpkgs.master];
}
