{ pkgs, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    sha256 = "1ac29jd04r31sri08c2dgfp1mkwbfp70hchpqd4cl25xr8khfg5p";
  }) {
    doomPrivateDir = ./doom.d;  # Directory containing your config.el, init.el
                                # and packages.el files
  };
in {
  home.packages = [ doom-emacs ];
}
