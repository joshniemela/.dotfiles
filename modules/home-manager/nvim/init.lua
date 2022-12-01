local opt = vim.opt
local g = vim.g


vim.cmd [[
    set nobackup
    set nowritebackup
    set noswapfile
    set noerrorbells
]]

-- Set leader key
g.mapleader = " "

-- Undo files
opt.undofile = true
opt.undodir = "/home/josh/.local/share/nvim/undo"

-- Indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

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

-- Remove viminfo
opt.viminfo = ""
opt.viminfofile = "NONE"

-- QoL
opt.smartcase = true
-- opt.ttimeoutlen = 5
opt.incsearch = true
opt.hlsearch = true
opt.autoread = true

require'nvim-treesitter.configs'.setup = {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
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


opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
lspconfig.sumneko_lua.setup({
    single_file_support = true,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lspconfig.rnix.setup({

})

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 2},
    {name = 'buffer', keyword_length = 2},
    {name = 'luasnip', keyword_length = 1},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = 'X',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

g.loaded_perl_provider = 0
vim.cmd('colorscheme habamax')
