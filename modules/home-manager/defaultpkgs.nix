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
      zathura # pdf viewer
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

      # Stuff for work
      teams # Microsoft Teams
      postman # for testing APIs
      seafile-client
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
    ];
  };
  services = {
    flameshot.enable = true;
  };
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      extraPackages = with pkgs; [
        nodejs-16_x
        dotnet-sdk
      ];
      viAlias = true;
      vimAlias = true;
      withNodeJs = false; # Copilot dosent support the latest v18
      withPython3 = true;
      vimdiffAlias = true;
      extraConfig = ''
        set t_Co=256
        let g:tex_flavor='latex'
        let g:vimtex_view_method='zathura'
        let g:vimtex_quickfix_mode=0
        set conceallevel=2
        let g:tex_conceal='abdmgs'
        hi clear Conceal

        set nu rnu
        highlight LineNrAbove ctermfg=57
        highlight LineNrBelow ctermfg=57
        highlight LineNr ctermfg=88

        # Makes FSAC work
        let g:fsharp#fsautocomplete_command =
          \ [ 'dotnet',
          \   'fsautocomplete'
          \ ]
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        Ionide-vim
        vim-nix
        vimtex
        copilot-vim
        rainbow
        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            tree-sitter-python
            tree-sitter-c
            tree-sitter-nix
            tree-sitter-rust
            tree-sitter-toml
            tree-sitter-json
            tree-sitter-cmake
            tree-sitter-comment
            tree-sitter-http
            tree-sitter-regex
            tree-sitter-dart
            tree-sitter-make
            tree-sitter-html
            tree-sitter-css
            tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-php
            tree-sitter-sql
            tree-sitter-dockerfile
            tree-sitter-haskell
            tree-sitter-julia
            tree-sitter-r
          ]))
      ];
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
