return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>a", group = "CopilotChat" },
			{ "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "Select models" },
			{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
			{ "<leader>aT", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
			{
				"<leader>ac",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "Ask input",
			},
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
			{ "<leader>af", "<cmd>CopilotChatFixError<cr>", desc = "Fix diagnostic" },
			{ "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer & history" },
			{ "<leader>am", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit message" },
			{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better naming" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
			{ "<leader>ai", ":CopilotChatInline", mode = "x", desc = "Inline chat" },
			{ "<leader>av", ":CopilotChatVisual", mode = "x", desc = "Open in vertical split" },
		})
	end,
}
