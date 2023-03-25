{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    #extensions = with pkgs.vscode-extensions; [
    #    james-yu.latex-workshop # Latex
    #    bbenoist.nix # Nix
    #    naumovs.color-highlight # Shows hex codes with colour
    #    pkief.material-icon-theme # Icon theme
    #    ms-python.python # Python IDE
    #    ms-python.vscode-pylance
    #    ionide.ionide-fsharp # F# IDE
    #    arrterian.nix-env-selector #nix env selector
    #    #github.copilot
    #]
    #++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #    { # Julia
    #    name = "language-julia";
    #    publisher = "julialang";
    #    version = "1.6.30";
    #    sha256 = "sha256-HZaltck0cKSBSPGCByLaIgui2tUf+aLmR56vyi60YUQ=";
    #    }
    #    { # Direnv extension
    #    name = "direnv";
    #    publisher = "mkhl";
    #    version = "0.6.1";
    #    sha256 = "sha256-5/Tqpn/7byl+z2ATflgKV1+rhdqj+XMEZNbGwDmGwLQ=";
    #    }
    #];
  };
  #environment.variables.EDITOR = [ "code" ];
}
