{ pkgs, lib, ...}:
{
    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        extensions = with pkgs.vscode-extensions; [
            james-yu.latex-workshop # Latex
            bbenoist.nix # Nix 
            naumovs.color-highlight # Shows hex codes with colour
            pkief.material-icon-theme # Icon theme
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            { # Julia
            name = "language-julia"; 
            publisher = "julialang";
            version = "1.6.30";
            sha256 = "sha256-HZaltck0cKSBSPGCByLaIgui2tUf+aLmR56vyi60YUQ=";
            }
        ];
    };
}