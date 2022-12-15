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
    #neovim = {
    #  enable = true;
    #  #coc.enable = true;
    #  package = pkgs.neovim-unwrapped;
    #  extraPackages = with pkgs; [
    #    nodejs-16_x
    #  ];
    #  extraPython3Packages = (ps: with ps; [
    #    sympy
    #  ]);
    #  viAlias = true;
    #  vimAlias = true;
    #  withNodeJs = false; # Copilot dosent support the latest v18
    #  withPython3 = true;
    #  vimdiffAlias = true;
    #  extraConfig = ''
    #    set t_Co=256
#
    #    " Latex stuff
    #    let g:tex_flavor='latex'
    #    let g:vimtex_view_method='zathura'
    #    let g:vimtex_quickfix_mode=0
    #    set conceallevel=2
    #    let g:tex_conceal='abdmgs'
    #    hi clear Conceal
#
    #    " Hybrid number line
    #    set nu rnu
    #    highlight LineNrAbove ctermfg=57
    #    highlight LineNrBelow ctermfg=57
    #    highlight LineNr ctermfg=88
#
    #    " F# stuff
    #    let g:fsharp#fsautocomplete_command =
    #    \ [ 'dotnet',
    #    \   'fsautocomplete'
    #    \ ]
#
    #    let g:fsharp#show_signature_on_cursor_move = 1
#
    #    lua << EOF
    #    local opts = { noremap=true, silent=true }
    #    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    #    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    #    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    #    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
#
    #    -- Use an on_attach function to only map the following keys
    #    -- after the language server attaches to the current buffer
    #    local on_attach = function(client, bufnr)
    #      -- Enable completion triggered by <c-x><c-o>
    #      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
#
    #      -- Mappings.
    #      -- See `:help vim.lsp.*` for documentation on any of the below functions
    #      local bufopts = { noremap=true, silent=true, buffer=bufnr }
    #      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    #      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    #      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    #      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    #      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    #      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    #      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    #      vim.keymap.set('n', '<space>wl', function()
    #        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    #      end, bufopts)
    #      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    #      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    #      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    #      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    #      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    #    end
    #    EOF
#
    #    lua << EOF
    #      require'lspconfig'.julials.setup{
    #        on_attach = on_attach,
    #        settings = {
    #          julia = {
    #            enable = true,
    #            lint = true,
    #            format = true,
    #            format_options = {
    #              indent = 2,
    #              margin = 92,
    #            },
    #          },
    #        },
    #      }
    #    EOF
    #    nmap <leader>ld :lua vim.lsp.buf.declaration()<CR>
    #    nmap <leader><leader> :lua vim.lsp.buf.hover()<CR>
    #    nmap <leader>ll :lua vim.lsp.util.show_line_diagnostics()<CR>
    #    nmap <leader>lk :lua vim.lsp.buf.signature_help()<CR>
    #    nmap <leader>lr :lua vim.lsp.buf.references()<CR>
#
    #    let g:latex_to_unicode_auto = 1
    #    let g:latex_to_unicode_tab = "off"
#
    #    let g:UltiSnipsExpandTrigger="<tab>"
    #    let g:UltiSnipsJumpForwardTrigger="<tab>"
    #    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    #    let g:UltiSnipsEditSplit="vertical"
    #  '';
    #  plugins = with pkgs.vimPlugins; [
    #    ultisnips
    #    nvim-lspconfig
    #    nvim-cmp
    #    julia-vim
    #    Ionide-vim
    #    vim-nix
    #    vimtex
    #    copilot-vim
    #    rainbow
    #    (nvim-treesitter.withPlugins (plugins:
    #      with plugins; [
    #        tree-sitter-python
    #        tree-sitter-c
    #        tree-sitter-nix
    #        tree-sitter-rust
    #        tree-sitter-toml
    #        tree-sitter-json
    #        tree-sitter-cmake
    #        tree-sitter-comment
    #        tree-sitter-http
    #        tree-sitter-regex
    #        tree-sitter-dart
    #        tree-sitter-make
    #        tree-sitter-html
    #        tree-sitter-css
    #        tree-sitter-latex
    #        tree-sitter-bibtex
    #        tree-sitter-php
    #        tree-sitter-sql
    #        tree-sitter-dockerfile
    #        tree-sitter-haskell
    #        tree-sitter-julia
    #        tree-sitter-r
    #      ]))
    #  ];
    #};
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
