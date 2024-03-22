{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (
      pkgs.callPackage (
        {
          pkgs,
          writeShellScriptBin,
          stdenv,
          config,
          ...
        }:
          pkgs.writeShellScriptBin "julia" ''
            export JULIA_NUM_THREADS="auto";
            export NIX_LD=${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/opengl-driver/lib"
            ${pkgs.julia_110-bin}/bin/julia "$@" ''
      ) {}
    )
  ];

  home.file.".julia/config/startup.jl".source = ./startup.jl;

  home.file.".julia/config/startup_ijulia.jl".text = ''
    # automatically reload code of imported libraries
    # https://timholy.github.io/Revise.jl/stable/config
    try
        @eval using Revise
    catch e
        @warn "Error initializing Revise" exception=(e, catch_backtrace())
    end
  '';
}
