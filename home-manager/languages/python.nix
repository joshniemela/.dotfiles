{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      # operator libs
      numpy
      #jax jaxlibWithCuda
      scipy

      # visualisation
      matplotlib seaborn

      # data loading
      pandas
    ]))
  ];
}
