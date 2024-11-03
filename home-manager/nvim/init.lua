local opt = vim.opt
local g = vim.g
local home = os.getenv("HOME")

require("colorizer").setup()

-- Set leader key
g.mapleader = " "
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

-- Theme
vim.cmd("colorscheme monokai")
