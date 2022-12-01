{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      nodejs-16_x
      rnix-lsp
      sumneko-lua-language-server
    ];
    extraPython3Packages = ( ps: with ps; [
      sympy
    ]);
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = true;
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./init.lua}
      luafile ${./lsp.lua}
      highlight LineNrAbove guifg=#401580
      highlight LineNrBelow guifg=#401580
    '';
    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      julia-vim
      Ionide-vim
      vim-nix
      vimtex
      copilot-vim
      luasnip
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-copilot
      cmp-latex-symbols
      # Treesitter
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-python
          tree-sitter-julia
          tree-sitter-nix
          tree-sitter-c
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-json
          tree-sitter-regex
          tree-sitter-html
          tree-sitter-css
          tree-sitter-latex
          tree-sitter-bibtex
          tree-sitter-lua
          tree-sitter-haskell
          tree-sitter-dockerfile
          tree-sitter-r
        ]))
    ];
  };
}
