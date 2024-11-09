return {
	{
		"nvim-neotest/neotest-go",
		ft = "*_test.go",
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
		end,
	},
	{
		"nvim-neotest/neotest",
		name = "neotest",
		event = "BufEnter *_test.go",
		dependencies = {
			"nvim-neotest/neotest-go",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						-- experimental = {
						--     test_table = true,
						--     note(2023-07-21): enabling this causes neotest to not be able to find any tests
						-- },
						-- note(2023-07-21): these seem unnecessary
						-- args = { "-count=1", "-timeout=60s" },
					}),
				},
			})
		end,
	},
}
