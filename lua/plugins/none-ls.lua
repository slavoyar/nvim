return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- Function to check for the presence of ESLint configuration files
		local has_eslint_config = function(utils)
			return utils.root_has_file({
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				"eslint.config.js",
				"eslint.config.cjs",
				"eslint.config.mjs",
			})
		end

		-- Function to handle LSP formatting
		local lsp_formatting = function(buffer)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = buffer,
			})
		end

		-- on_attach function to set up formatting on save
		local on_attach = function(client, buffer)
			if not buffer then
				return
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = buffer,
					callback = function()
						lsp_formatting(buffer)
					end,
				})
			end
		end

		-- Setup null-ls with conditional ESLint sources
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.prisma_format,
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.completion.luasnip,
				null_ls.builtins.formatting.stylua,
				require("none-ls.code_actions.eslint_d").with({
					condition = has_eslint_config,
				}),
				require("none-ls.diagnostics.eslint_d").with({
					condition = has_eslint_config,
				}),
				require("none-ls.formatting.eslint_d").with({
					condition = has_eslint_config,
				}),
			},
			on_attach = on_attach,
			debug = true,
		})

		vim.keymap.set("n", "<leader>gf", lsp_formatting)
	end,
}
