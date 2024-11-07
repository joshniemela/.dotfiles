{
  config,
  pkgs,
  lib,
  ...
}: let
  moonfly-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "moonfly-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "bluz71";
      repo = "vim-moonfly-colors";
      rev = "master";
      sha256 = "sha256-c+WHqece0Pb8oc2i/km0Spvo8JM3/0JnAJLkvPhAUHk=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      xdotool

      # Language servers
      sumneko-lua-language-server # Lua Language Server
      pyright # Python Language Server
      nil # Nix Language Server
      #haskell-language-server disabled due to haskell-tools-nvim containing HLS itself
      # rust-analyzer: Rust analyzer comes from global packages

      # Formatters
      stylua
      alejandra
      nodePackages.prettier
      ruff

      # Required for telescope-nvim
      ripgrep
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
      luafile ${./lsp.lua}
      luafile ${./telescope.lua}
      luafile ${./harpoon.lua}
    '';

    #luafile ${./snippets.lua}
    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      rainbow-delimiters-nvim
      lualine-nvim
      nvim-colorizer-lua

      # Theme
      moonfly-nvim

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
      nvim-lspconfig
      conform-nvim

      # AI-assisted autocompletion
      supermaven-nvim

      #which-key-nvim
      #plenary-nvim
      #haskell-tools-nvim
      #julia-vim

      ## new nvim
      telescope-nvim
      harpoon2

      (nvim-treesitter.withPlugins (p:
        with p; [
          nvim-ts-context-commentstring
          haskell
          nix
          lua
          python
          julia
          clojure
          rust
          c
          vimdoc
        ]))

      nvim-treesitter-context
    ];
  };
}
