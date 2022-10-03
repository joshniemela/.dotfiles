{ pkgs, config, ... }:
{
home.packages = [
  (
    pkgs.callPackage (
      { pkgs, writeShellScriptBin, stdenv, config, ... }:
      pkgs.writeShellScriptBin "julia" ''
      export JULIA_NUM_THREADS="auto";
      export NIX_LD=${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2
      export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib"
      ${pkgs.julia-bin}/bin/julia "$@" ''
    ) {}
  )
];

home.file.".julia/config/startup.jl".source = ./startup.jl;
}

