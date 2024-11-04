local lspconfig = require("lspconfig")

-- Lua LSP
lspconfig.lua_ls.setup({
	single_file_support = true,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Rust LSP
lspconfig.rust_analyzer.setup({})

-- Python LSP
lspconfig.pyright.setup({})

require("conform").setup({
	formatters_by_ft = {
		nix = { "alejandra" },
		lua = { "stylua" },

		javascript = { "prettier" },
		typescript = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },

		python = { "ruff_format" },
	},

	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},

	notify_on_error = true,
	notify_no_formatters = true,
})
-- local null_ls = require("null-ls")
-- local lsp_defaults = lspconfig.util.default_config
-- local g = vim.g
-- lsp_defaults.capabilities = vim.tbl_deep_extend(
--   'force',
--   lsp_defaults.capabilities,
--   require('cmp_nvim_lsp').default_capabilities()
-- )

-- -- Haskell LSP
-- -- local ht = require('haskell-tools')
-- -- local def_opts = { noremap = true, silent = true, }
-- -- ht.setup {
-- --   hls = {
-- --     -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
-- --     on_attach = function(client, bufnr)
-- --       local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
-- --       -- haskell-language-server relies heavily on codeLenses,
-- --       -- so auto-refresh (see advanced configuration) is enabled by default
-- --       vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
-- --       vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
-- --       -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
-- --     end,
-- --   },
-- -- }
-- -- Julia stuff
-- -- g.latex_to_unicode_tab = "off"
-- -- g.latex_to_unicode_suggestions = 0
-- -- g.latex_to_unicode_auto = 1
-- -- lspconfig.julials.setup{}
--
-- -- Suggested keymaps that do not depend on haskell-language-server
-- -- Toggle a GHCi repl for the current package
-- vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- -- Toggle a GHCi repl for the current buffer
-- vim.keymap.set('n', '<leader>rf', function()
--   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
-- end, def_opts)
-- vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)

-- Setup language servers.
-- lspconfig.tsserver.setup({})
-- lspconfig.clangd.setup({})
--
-- -- Global mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
--
-- -- Use LspAttach autocommand to only map the following keys
-- -- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(ev)
-- 		-- Enable completion triggered by <c-x><c-o>
-- 		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
-- 		-- Buffer local mappings.
-- 		-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 		local opts = { buffer = ev.buf }
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
-- 		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
-- 		vim.keymap.set("n", "<space>wl", function()
-- 			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 		end, opts)
-- 		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
-- 		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
-- 		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
-- 		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "<space>f", function()
-- 			vim.lsp.buf.format({ async = true })
-- 		end, opts)
-- 	end,
-- })
