return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  config = function()
    local null_ls = require("null-ls")

    local lsp_formatting = function(buffer)
      vim.lsp.buf.format({
        filter = function(client)
          -- By default, ignore any formatters provider by other LSPs
          -- (such as those managed via lspconfig or mason)
          -- Also "eslint as a formatter" doesn't work :(
          return client.name == "null-ls"
        end,
        bufnr = buffer
      })
    end

    local on_attach = function(client, buffer)
      -- the Buffer will be null in buffers like nvim-tree or new unsaved files
      if (not buffer) then return end

      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = buffer,
          callback = function()
            lsp_formatting(buffer)
          end
        })
      end
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.completion.luasnip,
        require("none-ls.code_actions.eslint_d"),
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d")
      },
      on_attach = on_attach
    })

    vim.keymap.set("n", "<leader>gf", lsp_formatting)
  end
}
