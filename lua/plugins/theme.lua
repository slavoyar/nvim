return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "theme",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
