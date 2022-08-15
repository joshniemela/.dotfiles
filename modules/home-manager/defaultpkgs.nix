{pkgs, webcord, ...}:
let
  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
  julia-wrapper = pkgs.callPackage ../../pkgs/julia-wrapper { inherit julia; };
in 
{
    home.packages = with pkgs; [
        youtube-dl
        neofetch
        thunderbird
        unison
        libreoffice
        viewnior
        gimp
        dotnet-sdk_5 # Required for F#
        pavucontrol
        tiled
        xournalpp # Modfiying PDF docs for signing
        tree
        julia-wrapper
        darktable
        webcord.packages.${system}.default
        hunspell
        hunspellDicts.en_GB-large # Dictionary for hunspell
        hunspellDicts.da_DK
        texlive.combined.scheme-full # Make this smaller in the future, I don't need the entire texlive enviroment
        lxappearance
        subversion
    ];
    services = {
        flameshot.enable = true;
    };
    programs = {
        mpv.enable = true; 
        sagemath.enable = true;
        alacritty.enable = true;
        direnv = {
            enable = true;
            nix-direnv.enable = true;
        };
    };
}