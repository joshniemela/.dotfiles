{ pkgs, webcord, ...}:
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
    lxappearance
    subversion
    texlive.combined.scheme-full
    qutebrowser
    imagemagick # Used for conversion of image formats
    gcc #C compiler
    # Stuff for work
    teams
    postman
    #(texlive.combine {
    #  inherit (pkgs.texlive) 
    #  scheme-medium
    #  amsmath
    #  fancyhdr
    #  lastpage
    #  pgf
    #  nomencl
    #  hyperref
    #  xkeyval
    #  latexmk
    #  latex-bin
    #  comma;
    #})
  ];
  services = {
    flameshot.enable = true;
  };
  programs = {
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
        show_cpu_frequency = true;
        show_cpu_temperature = true;
      };
    };
    mpv.enable = true; 
    alacritty.enable = true;
    direnv = {
        enable = true;
        nix-direnv.enable = true;
    };
  };
}
