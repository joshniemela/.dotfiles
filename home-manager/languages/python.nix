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
      scikit-learn

      # visualisation
      matplotlib seaborn

      # data loading
      pandas
      pytorch

      jupyter # i hate this
      ipython # i hate this
    ]))
  ];
}
