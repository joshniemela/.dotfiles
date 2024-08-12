{
  pkgs,
  tex2nix,
  ...
}: {
  home = {
    file.".unison/default.prf".source = ../configs/unison.prf; # File used for unison, TODO MAKE MODULE

    file."jdks/openjdk8".source = pkgs.openjdk8;

    packages = with pkgs; [
      # rust stuff
      rustc
      cargo
      rustfmt
      rust-analyzer

      # For installing lineage stuff / more android stuff
      #android-tools
      #heimdall

      discord
      #clang # Required for C
      #clang-tools
      gdb # Debugger for C
      valgrind # Memory checker for C

      discord

      prismlauncher

      # correction

      jq
      cmake
      gnumake
      nodejs
      p7zip
      neofetch # system info
      thunderbird # email
      evolution # also email
      unison # for syncing
      libreoffice # office suite
      viewnior # image viewer
      gimp # image editor
      pavucontrol # audio control
      xournalpp # for signing pdfs
      tree # for viewing directory structure
      darktable # photo editor
      #hunspell # spell checker
      #hunspellDicts.en_GB-large # Dictionary for hunspell
      #hunspellDicts.da_DK # Dictionary for hunspell
      lxappearance # for changing gtk theme
      texlive.combined.scheme-full # for latex
      pandoc
      chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      pstree
      xclip # for copying to clipboard

      simplescreenrecorder
      zip # for compressing files
      unzip # for uncompressing files
      bat # better cat
      btop # better htop

      # Languages
      rustc # Required for Rust
      cargo # Required for Rust
      futhark

      baobab
      wget
      xorg.xev
      pandoc
      inkscape
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
