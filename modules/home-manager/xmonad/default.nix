{config, pkgs, lib, ...}:

{
  config = {
    home.packages = with pkgs; [
      haskellPackages.haskell-language-server
      haskellPackages.hoogle
      haskellPackages.xmobar
      cabal-install
      ghc
      gnome.zenity
    ];

    home.file.".xmonad/xmobar.hs".source = ./xmobar.hs;
    # programs.xmobar = {
    #   enable = true;
    #   extraConfig = lib.readFile ./xmobarrc;
    # };

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
