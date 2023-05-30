{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.virtualbox.host = {
    enable = false;
    enableExtensionPack = false;
  };
}
