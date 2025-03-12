{pkgs, ...}: let
  dotnetfhs = pkgs.buildFHSEnv {
    name = "dotnet_x11";
    targetPkgs = pkgs:
      (with pkgs; [
        dotnet-sdk
      ])
      ++ (with pkgs.xorg; [
        libX11
        libXrandr
        libXcursor
      ]);
    runScript = "dotnet_x11";
  };
in {
  home.packages = [
    pkgs.dotnet-sdk
    dotnetfhs
  ];
  home.sessionVariables = {
    PATH = ''$PATH::$HOME/.dotnet/tools'';
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };
  # OR
  # environment.systemPackages = [ dotnetfhs ];
  #environment.sessionVariables = {
  #  DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
  #};
}
