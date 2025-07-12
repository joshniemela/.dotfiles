{
  lib,
  ...
}:
{
  programs.nvf.settings.vim = {
    utility.oil-nvim = {
      enable = true;
      setupOpts = {
        default_file_explorer = true;
        skip_confirm_for_simple_edits = true;

        view_options = {
          show_hidden = true;
          natural_order = true;

          is_always_hidden = lib.mkLuaInline ''
            function(name, _)
              return name == ".." or name == ".git"
            end
          '';
        };

        win_options.wrap = true;
      };
    };

    git.gitsigns = {
      enable = true;
      codeActions.enable = true;

      setupOpts = {
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 100;
        };
      };
    };

    keymaps = [
      {
        key = "-";
        mode = [ "n" ];
        action = ":Oil<CR>";
        silent = true;
        desc = "Open parent directory";
      }
    ];

    autopairs.nvim-autopairs.enable = true;
    autocomplete.nvim-cmp.enable = true;
  };
}
