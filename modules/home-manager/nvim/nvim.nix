{config, pkgs, lib, ...}:
let
  monokai-nvim = pkgs.vimUtils.buildVimPlugin {
    name="monokai-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tanvirtin";
      repo = "monokai.nvim";
      rev = "master";
      sha256 = "sha256-/otcoUETz6OMOaSUpYke4evrJIxxRA7crYbsh8d972M=";
    };
  };
in
  {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      xdotool
      rnix-lsp
      sumneko-lua-language-server
      # haskell-language-server
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./init.lua}
      luafile ${./snippets.lua}
      luafile ${./cmp.lua}
      luafile ${./lsp.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      lualine-nvim
      nvim-colorizer-lua
      # Theme
      monokai-nvim
      # UI
      vimtex
      luasnip
      nvim-cmp
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-latex-symbols
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help

      nvim-lspconfig

      plenary-nvim
      haskell-tools-nvim
      vim-nix
      
      (nvim-treesitter.withPlugins (p: with p; [
        nvim-ts-context-commentstring
        haskell
        nix 
        lua
    ]))
      nvim-treesitter-context
      ];
  };
}
