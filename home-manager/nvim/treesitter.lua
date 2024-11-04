require("nvim-treesitter.configs").setup({
	sync_install = false,
	auto_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

local highlight = {
	"RoyalPurple",
	"EggplantPurple",
	"GrapePurple",
	"OrchidPurple",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	-- Oranges
	vim.api.nvim_set_hl(0, "MangoOrange", { fg = "#FF8C42" })
	vim.api.nvim_set_hl(0, "RoyalPurple", { fg = "#7851A9" })
	vim.api.nvim_set_hl(0, "EggplantPurple", { fg = "#614051" })
	vim.api.nvim_set_hl(0, "GrapePurple", { fg = "#6F2DA8" })
	vim.api.nvim_set_hl(0, "OrchidPurple", { fg = "#DA70D6" })
end)

require("ibl").setup({ indent = { highlight = highlight }, scope = { highlight = "MangoOrange" } })
vim.g.rainbow_delimiters = { highlight = highlight }
