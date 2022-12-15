{config, pkgs, lib, ...}:
let
  monokai-nvim = pkgs.vimUtils.buildVimPlugin {
    name="monokai-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tanvirtin";
      repo = "monokai.nvim";
      rev = "master";
      sha256 = "sha256-++gmw/LWdb6+WV/t/w5KZ6D59Nwxi0DXFbDNE9fUvAA=";
    };
  };
in
  {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      nodejs-16_x # Required for copilot
      rnix-lsp
      sumneko-lua-language-server
      haskell-language-server
      xdotool
    ];
    extraPython3Packages = ( ps: with ps; [
      sympy
    ]);
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = true; # Used for sympy
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./init.lua}
      luafile ${./snippets.lua}
      luafile ${./lsp.lua}

      highlight LineNrAbove guifg=#401580
      highlight LineNrBelow guifg=#401580

      let g:fsharp#fsautocomplete_command =
      \ [ 'dotnet',
      \   'fsautocomplete'
      \ ]
    '';
    plugins = with pkgs.vimPlugins; [
      # Theme
      monokai-nvim
      # UI
      lualine-nvim
      nvim-colorizer-lua

      telescope-nvim
      telescope-file-browser-nvim
      indent-blankline-nvim
      harpoon
      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      julia-vim
      Ionide-vim
      haskell-vim
      vim-nix
      vimtex
      copilot-vim
      luasnip
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-copilot
      cmp-latex-symbols
      friendly-snippets
      vim-surround
      nvim-autopairs
      which-key-nvim

      # Treesitter
      (nvim-treesitter.withPlugins (p: with p; [
        nvim-ts-context-commentstring
        #playground
        julia
        haskell
        nix
        latex
        python
        lua
        rust
        c
        cpp
        bash
        vim
        toml
        json
        yaml
        html
        css
      ]))
      nvim-treesitter-context
      nvim-treesitter-textobjects
      #nvim-treesitter-refactor
    ];
  };
}
