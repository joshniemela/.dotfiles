{ lib, writeShellScriptBin, julia, zlib, openssl, qt5, freetype, libpng, stdenv, libGL }:

let 
  libs = [
    #freetype
    #libpng
    #openssl
    #qt5.qtbase
    #stdenv.cc.cc.lib
    #zlib
    libGL
  ];
in
writeShellScriptBin "julia" ''
  # Set variables for nix-ld
  export NIX_LD_LIBRARY_PATH=${lib.makeLibraryPath libs}
  export NIX_LD=${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2
  export NIX_LD=${libGL}/lib/ld-linux-x86-64.so.2
  ${julia}/bin/julia "$@"
''

