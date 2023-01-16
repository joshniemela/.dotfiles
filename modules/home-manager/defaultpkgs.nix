{ pkgs, webcord, tex2nix, ...}:
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
      sage
      tex2nix.defaultPackage.${system}
      texlive.combined.scheme-full # for latex
      #chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      pstree
      xclip # for copying to clipboard
      # Stuff for work
      teams # Microsoft Teams
      postman # for testing APIs
      seafile-client
      slack-cli
      simplescreenrecorder
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
      xorg.xev
    ];
  };
  services = {
    flameshot.enable = true;
  };
  programs = {

    kitty.enable = true;
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
