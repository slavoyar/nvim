return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-jest",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						dap = {
							type = "pwa-node",
							request = "launch",
							args = "--runInBand",
							cwd = vim.fn.getcwd(),
							console = "intergratedTerminal",
							sourceMaps = true,
							protocol = "inspector",
						},
					}),
				},
			})

			vim.keymap.set("n", "<leader>tt", ":lua require('neotest').run.run()<CR>", {})
			vim.keymap.set("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", {})
			vim.keymap.set("n", "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>", {})
		end,
	},
}
