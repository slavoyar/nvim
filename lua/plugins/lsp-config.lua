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
				"vue_ls",
				"vtsls",
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

			-- Setup other language servers
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascriptreact", "typescript", "typescriptreact", "vue" },
			})

			lspconfig.prismals.setup({ capabilities = capabilities })

			-- vue_ls setup with req'd hack to forward TS calls to vtsls
			lspconfig.vue_ls.setup({
				capabilities = capabilities,
				filetypes = { "vue" },
			})

			-- ts_ls setup — strictly for pure TS
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				root_dir = function(bufnr)
					return require("lspconfig.util").find_git_ancestor(vim.api.nvim_buf_get_name(bufnr))
				end,
			})

			-- Key mappings for LSP functions
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			vim.lsp.enable("vue_ls")
			vim.lsp.enable("ts_ls")
		end,
	},
}
