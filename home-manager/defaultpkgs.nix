{
  pkgs,
  tex2nix,
  ...
}: {
  home = {
    file.".unison/default.prf".source = ../configs/unison.prf; # File used for unison, TODO MAKE MODULE

    packages = with pkgs; [
      # rust stuff
      rustc
      cargo
      rustfmt
      rust-analyzer
      openapi-generator-cli

      # installing lineage stuff
      android-tools
      heimdall

      discord

      # correction

      jq
      cmake
      gnumake
      nodejs
      p7zip
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
      # qutebrowser # web browser
      texlive.combined.scheme-full # for latex
      pandoc
      #chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      pstree
      xclip # for copying to clipboard
      # Stuff for work
      simplescreenrecorder
      zip # for compressing files
      unzip # for uncompressing files
      bat # better cat
      btop # better htop
      # Languages
      #nodejs # Required for javascript
      #bun

      rustc # Required for Rust
      cargo # Required for Rust

      clang # Required for C
      clang-tools
      gdb # Debugger for C
      valgrind # Memory checker for C

      baobab
      wget
      xorg.xev
      pandoc
      inkscape
      #futhark broken since 10/24/23
      logseq
      shellcheck
    ];
  };
  services = {
    flameshot.enable = true;
  };
  programs = {
    tmux = {
      enable = false;
      clock24 = true;
    };

    zathura.enable = true;

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
