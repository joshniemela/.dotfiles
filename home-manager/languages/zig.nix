{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.zig pkgs.zls];
}
