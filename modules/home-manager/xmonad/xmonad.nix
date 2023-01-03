{config, pkgs, lib, ...}:

{
  config = {
    home.packages = with pkgs; [
      haskellPackages.haskell-language-server
      haskellPackages.hoogle
      cabal-install
      ghc
    ];
    programs.xmobar = {
      enable = true;
      extraConfig = lib.readFile ./xmobarrc;
    };

    xsession = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
    };
  };
}
