{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    projects.project-nvim = {
      enable = true;
      manualMode = false;
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
