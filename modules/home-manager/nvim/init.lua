local opt = vim.opt
local g = vim.g

-- Set leader key
g.mapleader = " "

-- Undo files
opt.undofile = true
opt.undodir = "/home/josh/.local/share/nvim/undo"
-- Indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.scrolloff = 8
opt.timeoutlen = 500
opt.updatetime = 250
opt.showmatch = true
-- Clipboard mode
opt.clipboard = "unnamedplus"

-- Allow mouse
opt.mouse = "a"

-- UI
opt.termguicolors = true -- causing weird colors
opt.cursorline = true

-- Hybrid line numbers
opt.number = true
opt.relativenumber = true



-- Line context
opt.list = true
require("indent_blankline").setup{
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

-- Remove viminfo
opt.viminfo = ""
opt.viminfofile = "NONE"

-- QoL
opt.smartcase = true
opt.smartcase = true
-- opt.ttimeoutlen = 5
opt.incsearch = true
opt.hlsearch = true
opt.autoread = true
require'colorizer'.setup()
require('lualine').setup{
  options = {
    theme = 'auto'
  }
}

-- Latex
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
g.vimtex_flavor = "latex"
g.vimtex_conceal = "abdmgs"
vim.cmd [[ 
    set conceallevel=2
    hi clear Conceal
]]



-- Highlight yank'd text after yankin'
vim.api.nvim_create_augroup("YankHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})


g.loaded_perl_provider = 0
vim.cmd('colorscheme monokai')

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true, disable = {"latex"}},
  indent = {enable = true},
  context_commentstring = {enable = true}
}
require("which-key").setup {}
