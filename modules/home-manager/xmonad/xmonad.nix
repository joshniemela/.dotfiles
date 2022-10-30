{config, pkgs, lib, ...}:

{
  config = {
    xsession = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        #config = ./xmonad.hs;
        #extraPackages = [
        #
        #];
      };
    };
  };
}