local g = vim.g
local opt = vim.opt

opt.completeopt = {'menu', 'noinsert', 'preview'}

local cmp = require('cmp')

local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}


cmp.setup.cmdline('/', {{
    sources = { name = 'buffer' },
}})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  matching = { disallow_fuzzy_matching = false },
  },
  sources = {
    {name = 'nvim_lsp_signature_help' },
    {name = 'luasnip', option={show_autosnippets = true} },
    {name = 'path'},
    {name = 'nvim_lsp', max_item_count=10},
    {name = 'buffer', keyword_length=4},
    {name = 'copilot', keyword_length = 1},
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
        path = '$',
        --copilot = '🚀',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-8),
    ['<C-f>'] = cmp.mapping.scroll_docs(8),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm{ select = true },
    ['<Tab>'] = cmp.mapping(function (fallback)
      if luasnip.expandable() then
          luasnip.expand()
      elseif cmp.visible() then
          cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
      else
          fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
          cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
      else
          fallback()
      end
    end, {'i', 's'})
  },
})


