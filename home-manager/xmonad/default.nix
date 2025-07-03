{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        haskellPackages.haskell-language-server
        haskellPackages.hoogle
        haskellPackages.xmobar
        cabal-install
        ghc
        zenity
        fourmolu
      ];

      xsession = {
        enable = true;

        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = ./xmonad.hs;
        };
      };
    }
    (lib.mkIf (osConfig.networking.hostName == "desktop") {
      home.file.".xmonad/xmobar.hs".source = ./xmobar-desktop.hs;
    })

    (lib.mkIf (osConfig.networking.hostName == "thonkpad") {
      home.file.".xmonad/xmobar.hs".source = ./xmobar-thonkpad.hs;
    })
  ];
}
