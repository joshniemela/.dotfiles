{ lib, writeShellScriptBin, julia, stdenv }:

#let 
#  libs = [
    #freetype
    #libpng
    #openssl
    #qt5.qtbase
    #stdenv.cc.cc.lib
    #zlib
    #libGL
#  ];
#in
writeShellScriptBin "julia" ''
  export JULIA_NUM_THREADS="auto";
  export NIX_LD=${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib"
  ${julia}/bin/julia "$@"
''

