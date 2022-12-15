{ pkgs, webcord, ...}:
#let
#  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
#  julia-wrapper = pkgs.callPackage ../../modules/julia { inherit julia; };
#in 
{
  home = {
    file.".unison/default.prf".source  = ../../configs/unison.prf; # File used for unison, TODO MAKE MODULE

    packages = with pkgs; [
      youtube-dl # for downloading youtube videos
      neofetch # system info
      thunderbird # email
      unison # for syncing
      libreoffice # office suite
      viewnior # image viewer
      gimp # image editor
      pavucontrol # audio control
      xournalpp # for signing pdfs
      tree # for viewing directory structure
      darktable # photo editor
      webcord.packages.${system}.default # discord
      hunspell # spell checker
      hunspellDicts.en_GB-large # Dictionary for hunspell
      hunspellDicts.da_DK # Dictionary for hunspell
      lxappearance # for changing gtk theme
      subversion # for svn
      # qutebrowser # web browser
      texlive.combined.scheme-full # for latex
      timewarrior
      taskwarrior
      sage
      #chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      pstree
      xclip # for copying to clipboard
      # Stuff for work
      teams # Microsoft Teams
      postman # for testing APIs
      seafile-client
      tectonic # for compiling latex
      slack-cli
      simplescreenrecorder
      #TODO FIX LATEX
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
      #  comma;"ctrl-b" TUI
      #})
      zip  # for compressing files
      unzip # for uncompressing files
      bat # better cat
      btop # better htop

      # Languages
      #nodejs # Required for javascript
      rustc # Required for Rust
      cargo # Required for Rust
      gcc # Required for C
      baobab
      rstudio
      wget
    ];
  };
  services = {
    flameshot.enable = true;
  };
  programs = {
    zathura = {
      enable = true;
    };


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
