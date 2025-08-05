{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    projects = {
      project-nvim = {
        setupOpts = {
          manual_mode = false;
        };
        enable = true;

      };
    };
    telescope = {
      enable = true;

      extensions = [
        {
          name = "fzf";
          packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
          setup = {
            fzf = {
              fuzzy = true;
            };
          };
        }
      ];
    };
  };
}
