{
  programs.nvf.settings.vim = {
    luaConfigRC.highlights = ''
      local highlight = {
      	"RoyalPurple",
      	"EggplantPurple",
      	"GrapePurple",
      	"OrchidPurple",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      	-- Oranges
      	vim.api.nvim_set_hl(0, "MangoOrange", { fg = "#FF8C42" })
      	vim.api.nvim_set_hl(0, "RoyalPurple", { fg = "#7851A9" })
      	vim.api.nvim_set_hl(0, "EggplantPurple", { fg = "#614051" })
      	vim.api.nvim_set_hl(0, "GrapePurple", { fg = "#6F2DA8" })
      	vim.api.nvim_set_hl(0, "OrchidPurple", { fg = "#DA70D6" })
      end)

      require("ibl").setup({ indent = { highlight = highlight }, scope = { highlight = "MangoOrange" } })
      vim.g.rainbow_delimiters = { highlight = highlight }
    '';

    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      context.enable = true;
    };

    visuals = {
      rainbow-delimiters.enable = true;
      indent-blankline.enable = true;

      nvim-web-devicons = {
        enable = true;
        setupOpts = {
          color_icons = true;
          default = true;
          strict = true;
          variant = "dark";
        };
      };

      highlight-undo.enable = true;
    };
  };
}
