{ pkgs, webcord, tex2nix, ...}:
#let
#  julia = pkgs.julia-bin; # import ../../pkgs/julia-bin.nix { pkgs = pkgs; };
#  julia-wrapper = pkgs.callPackage ../../modules/julia { inherit julia; };
#in 
{
  home = {
    file.".unison/default.prf".source  = ../../configs/unison.prf; # File used for unison, TODO MAKE MODULE

    packages = with pkgs; [
      csv2parquet
      p7zip
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
      hunspell # spell checker
      hunspellDicts.en_GB-large # Dictionary for hunspell
      hunspellDicts.da_DK # Dictionary for hunspell
      lxappearance # for changing gtk theme
      subversion # for svn
      # qutebrowser # web browser
      #tex2nix.defaultPackage.${system}
      texlive.combined.scheme-full # for latex
      pandoc
      #chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      pstree
      xclip # for copying to clipboard
      # Stuff for work
      postman # for testing APIs
      seafile-client
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
      #rstudio
      wget
      xorg.xev
      pandoc
      inkscape
    ];
  };
  services = {
    flameshot.enable = true;
  };
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
    };

    zathura = {
      enable = true;
    };

    #sagemath.enable = true;


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
    kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code;
      };
      settings = {
      };
    };
    direnv = {
        enable = true;
        nix-direnv.enable = true;
    };
  };
}
