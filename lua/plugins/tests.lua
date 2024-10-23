return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-jest')({
            jestCommand = "npm run jest",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        }
      })

      vim.keymap.set("n", "<leader>tt", ":lua require('neotest').run.run()<CR>", {})
      vim.keymap.set("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", {})
      vim.keymap.set("n", "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>", {})
    end
  }
}
