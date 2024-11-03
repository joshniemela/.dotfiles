local g = vim.g
local opt = vim.opt

opt.completeopt = { "menu", "noinsert", "preview" }

local cmp = require("cmp")

require("supermaven-nvim").setup({
	disable_inline_completion = false,
	keymaps = {
		accept_suggestion = "<Tab>",
		clear_suggestion = "<C-Tab>",
		accept_word = "<C-Space>",
	},
	color = {
		suggestion_color = "#D75F00",
    -- this is the 256 colour of the same colour
		cterm = 166,
	},
})

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup.cmdline("/", { {
	sources = { name = "buffer" },
} })

cmp.setup({
	sources = {
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "buffer", keyword_length = 4 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				buffer = "Ω",
				path = "$",
				supermaven = "✨",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(8)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.scroll_docs(-8)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
