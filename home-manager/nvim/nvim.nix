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
      sumneko-lua-language-server
      #ripgrep
      #pyright
      #black
      #haskell-language-server disabled due to haskell-tools-nvim containing HLS itself
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./init.lua}
      luafile ${./treesitter.lua}
      luafile ${./cmp.lua}
    '';
    #luafile ${./telescope.lua}
    #luafile ${./harpoon.lua}
    #luafile ${./lsp.lua}

    #luafile ${./snippets.lua}
    plugins = with pkgs.vimPlugins; [
      supermaven-nvim
      indent-blankline-nvim
      #lualine-nvim
      nvim-colorizer-lua
      # Theme
      monokai-nvim
      # UI
      #vimtex
      #luasnip
      nvim-cmp
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-latex-symbols
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      #null-ls-nvim
      #nvim-lspconfig

      #which-key-nvim
      #plenary-nvim
      #haskell-tools-nvim
      #vim-nix
      #julia-vim

      ## new nvim
      #telescope-nvim
      #harpoon

      (nvim-treesitter.withPlugins (p:
        with p; [
          nvim-ts-context-commentstring
          haskell
          nix
          lua
          python
          julia
          clojure
          c
          vimdoc
        ]))

      nvim-treesitter-context
    ];
  };
}
