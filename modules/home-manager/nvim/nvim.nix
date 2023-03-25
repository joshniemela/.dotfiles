{
  config,
  pkgs,
  lib,
  ...
}: let
  monokai-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "monokai-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tanvirtin";
      repo = "monokai.nvim";
      rev = "master";
      sha256 = "sha256-Q6+la2P2L1QmdsRKszBBMee8oLXHwdJGWjG/FMMFgT0=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      xdotool
      rnix-lsp
      sumneko-lua-language-server
      pyright
      # haskell-language-server disabled due to haskell-tools-nvim containing HLS itself
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
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
      copilot-vim

      nvim-lspconfig

      which-key-nvim
      plenary-nvim
      haskell-tools-nvim
      vim-nix
      julia-vim

      (nvim-treesitter.withPlugins (p:
        with p; [
          nvim-ts-context-commentstring
          haskell
          nix
          lua
          python
          julia
        ]))

      nvim-treesitter-context
    ];
  };
}
