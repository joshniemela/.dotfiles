{ pkgs ? import <nixpkgs> {} }:
let 
    haskellPkgs = ps: with ps; [
        haskell-language-server
        hlint
        ghcid
        stylish-haskell
        xmonad
        xmonad-contrib
    ];
    ghc = pkgs.haskellPackages.ghcWithPackages haskellPkgs;
in
    pkgs.mkShell {
        name = "haskell dev shell";
        buildInputs = [
            ghc
        ];
    }

