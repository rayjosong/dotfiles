return {
	{
		"tpope/vim-fugitive",
	},
	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	config = function()
	-- 		require("gitsigns").setup()
	--
	-- 		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
	-- 		vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
	-- 	end,
	-- },
	{
		"APZelos/blamer.nvim",
		event = "BufReadPre",
		keys = "<leader>gb",
		setup = function()
			vim.g.blamer_enabled = 1
			vim.g.blamer_delay = 500
			vim.g.blamer_template = " %s | %s "
		end,
	},
}
