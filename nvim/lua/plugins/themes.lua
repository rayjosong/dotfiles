return {
	{
		"nyoom-engineering/oxocarbon.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = { "gruvbox", "oxocarbon", "catppuccin" }, -- Your list of installed colorschemes.
				livePreview = true,
			})
		end,
	},
}
