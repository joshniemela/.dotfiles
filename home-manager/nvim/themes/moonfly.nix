{
  pkgs,
  ...
}:
let
  moonfly-nvim-pkg = pkgs.vimUtils.buildVimPlugin {
    name = "moonfly-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "bluz71";
      repo = "vim-moonfly-colors";
      rev = "master";
      sha256 = "sha256-v8U6Gsm5oKZPdKxex7XcJQX3az6M47YK4H5Kfx5lzpE=";
    };
  };
in
{
  programs.nvf = {
    settings.vim.extraPlugins.moonfly = {
      package = moonfly-nvim-pkg;
      setup = ''vim.cmd("colorscheme moonfly")'';
    };
  };
}
