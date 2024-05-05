local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')


-- TypeScript
nvim_lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "vue" },
  cmd = { "typescript-language-server", "--stdio" }
}

nvim_lsp.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro"  },
  cmd = { "vscode-eslint-language-server", "--stdio" },
  settings = {
      workingDirectory = {
        mode = "auto"
      },
      codeActionOnSave = {
        enable = true,
        mode = "all"
      }
  }
}

