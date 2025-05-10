return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"prismals",
				"volar",
				"cssls",
				"tailwindcss",
				"ast_grep",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Define the path to the @vue/typescript-plugin
			local vue_typescript_plugin_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

			-- Setup TypeScript server with Vue plugin
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_typescript_plugin_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "typescriptreact", "vue" },
			})

			-- Setup other language servers
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascriptreact", "typescript", "typescriptreact", "vue" },
			})
			lspconfig.prismals.setup({ capabilities = capabilities })
			lspconfig.volar.setup({ capabilities = capabilities })

			-- Key mappings for LSP functions
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
