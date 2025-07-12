{
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default

    ./themes/moonfly.nix
    ./visual.nix
    ./treesitter.nix
    ./utility.nix
    ./lsp.nix
    ./telescope.nix
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      preventJunkFiles = true;
      enableLuaLoader = true;
      statusline.lualine = {
        enable = true;

        activeSection.b = [
          ''
            {
              "filetype",
              colored = true,
              icon_only = true,
              icon = { align = 'left' }
            }
          ''
          ''
            {
              "filename",
              path=1,
              symbols = {modified = ' ', readonly = ' '},
              separator = {right = ''}
            }
          ''
          ''
            {
              "",
              draw_empty = true,
              separator = { left = '', right = '' }
            }
          ''
        ];
      };
      ui.colorizer.enable = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        autoindent = true;
        smartindent = true;
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
        scrolloff = 8;
        showmatch = true;

        updatetime = 100;
        tm = 300;

        # Undo file
        undofile = true;

        # UI
        termguicolors = true;
        cursorline = true;

        # Line context
        list = true;

        # Remove viminfo
        viminfo = "";
        viminfofile = "NONE";

        # QoL
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        hlsearch = true;
      };

      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };

      augroups = [
        {
          name = "highlight-yank";
          clear = true;
        }
      ];

      autocmds = [
        {
          event = [ "TextYankPost" ];
          desc = "Highlight when yanking text";
          group = "highlight-yank";
          callback = lib.mkLuaInline ''
            function()
              vim.highlight.on_yank()
            end
          '';
        }
      ];
    };
  };
}
