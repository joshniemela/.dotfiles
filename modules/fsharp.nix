{pkgs, ...}: let
  dotnetfhs = pkgs.buildFHSUserEnv {
    name = "dotnet";
    targetPkgs = pkgs:
      (with pkgs; [
        dotnet-sdk
      ])
      ++ (with pkgs.xorg; [
        libX11
        libXrandr
        libXcursor
      ]);
    runScript = "dotnet";
  };
in {
  home.packages = [dotnetfhs];
  home.sessionVariables = {PATH = ''$PATH::$HOME/.dotnet/tools'';};
  # OR
  # environment.systemPackages = [ dotnetfhs ];
}
