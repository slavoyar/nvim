return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		optional = true,
		opts = {
			file_types = { "markdown", "copilot-chat" },
		},
		ft = { "markdown", "copilot-chat" },
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local chat = require("CopilotChat")

			local provider_cfg = require("CopilotChat.config").providers
			provider_cfg.openrouter = {
				prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
				prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
				get_headers = function()
					local api_key = assert(os.getenv("OPENROUTER_API_KEY"), "OPENROUTER_API_KEY env not set")
					return {
						Authorization = "Bearer " .. api_key,
						["Content-Type"] = "application/json",
					}
				end,
				get_models = function(headers)
					local response, err = require("CopilotChat.utils").curl_get("https://openrouter.ai/api/v1/models", {
						headers = headers,
						json_response = true,
					})
					if err then
						error(err)
					end
					return vim.iter(response.body.data)
						:map(function(model)
							return { id = model.id, name = model.name }
						end)
						:totable()
				end,
				get_url = function()
					return "https://openrouter.ai/api/v1/chat/completions"
				end,
			}

			local select = require("CopilotChat.select")

			chat.setup({
				question_header = "## User ",
				answer_header = "## Copilot ",
				error_header = "## Error ",
				model = "qwen/qwen3-30b-a3b:free",
				providers = require("CopilotChat.config").providers,
				window = {
					layout = "vertical",
					width = 0.3,
				},
			})

			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Code related commands
			{ "<leader>ae", "<cmd>CopilotChatExplain #buffer<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>at", "<cmd>CopilotChatTests #buffer<cr>", desc = "CopilotChat - Generate tests" },
			{ "<leader>ar", "<cmd>CopilotChatReview #buffer<cr>", desc = "CopilotChat - Review code" },
			{ "<leader>an", "<cmd>CopilotChatBetterNamings #buffer<cr>", desc = "CopilotChat - Better Naming" },
			-- Chat with Copilot in visual mode
			{
				"<leader>av",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ai",
				":CopilotChatInline",
				mode = "x",
				desc = "CopilotChat - Inline chat",
			},
			-- Custom input for CopilotChat
			{
				"<leader>ac",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "CopilotChat - Ask input",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
			-- Toggle Copilot Chat Vsplit
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
			-- Copilot Chat Models
			{ "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
		},
	},
}
