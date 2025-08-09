return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>a", group = "CopilotChat" },

			{ "<leader>f", group = "Telescope" },
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "List buffers" },
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Help tags" },

			{ "<leader>g", group = "Git" },
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Git hunk" },
			{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle blame" },
			{ "<leader>i", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostics" },

			{ "<leader>t", group = "Testing" },
			{ "<leader>tt", ":lua require('neotest').run.run()<CR>", desc = "Run test" },
			{
				"<leader>tf",
				":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
				desc = "Run file tests",
			},
			{
				"<leader>td",
				":lua require('neotest').run.run({strategy = 'dap'})<CR>",
				desc = "Debug test",
			},
			{
				"<leader>tb",
				'<cmd>lua require("dap").toggle_breakpoint()<CR>',
			},
		})
	end,
}
