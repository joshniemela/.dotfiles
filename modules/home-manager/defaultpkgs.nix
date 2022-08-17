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
    #texlive.combined.scheme-full # Make this smaller in the future, I don't need the entire texlive enviroment
    lxappearance
    subversion
    pkgs.texlive.combine {
      inherit (pkgs. texlive) 
      scheme-full
      amsmath
      latex-bin
      latexmk
      fancyhdr
      lastpage
      pgf
      nomencl
      hyperref
      xkeyval
      comma;
    }
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
