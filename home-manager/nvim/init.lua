local opt = vim.opt
local g = vim.g
local home = os.getenv("HOME")

require("colorizer").setup()
require("lualine").setup()

-- Set leader key
g.mapleader = " "
g.maplocalleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Undo files
opt.undofile = true
opt.undodir = home .. ".local/share/nvim/undo,/tmp"
-- Backup
opt.backup = true
opt.backupdir = home .. ".local/share/nvim/backup,/tmp"

-- Indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.scrolloff = 8
opt.timeoutlen = 300
opt.updatetime = 250
opt.showmatch = true
-- Clipboard mode, loads async to reduce startup time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

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

-- Remove viminfo
opt.viminfo = ""
opt.viminfofile = "NONE"

-- QoL
opt.ignorecase = true
opt.smartcase = true
-- opt.ttimeoutlen = 5
opt.incsearch = true
opt.hlsearch = true
opt.autoread = true

-- Theme
vim.cmd("colorscheme moonfly")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
