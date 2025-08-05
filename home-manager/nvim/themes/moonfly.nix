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
      sha256 = "sha256-O1DG8LA9eoOnCt9A0i0CFfpZeAK/obM8fYpMea2CPcA=";
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
