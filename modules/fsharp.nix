{ pkgs, ... }:

let dotnetfhs = pkgs.buildFHSUserEnv {
    name = "dotnet";
    targetPkgs = pkgs: (with pkgs; [
        dotnet-sdk
    ]) ++ (with pkgs.xorg; [
        libX11
        libXrandr
        libXcursor
    ]);
    runScript = "dotnet";
};

in {
    home.packages = [ dotnetfhs ];
    # OR
    # environment.systemPackages = [ dotnetfhs ];
}