local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug('Mofiqul/vscode.nvim')
    Plug('preservim/nerdtree')
    Plug('Xuyuanp/nerdtree-git-plugin')
    Plug('tiagofumo/vim-nerdtree-syntax-highlight')
    Plug('nvim-lualine/lualine.nvim')
    Plug 'romgrk/barbar.nvim'

    Plug('neovim/nvim-lspconfig')
    Plug('jose-elias-alvarez/null-ls.nvim')
    Plug('MunifTanjim/eslint.nvim')
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    Plug('ryanoasis/vim-devicons')
vim.call('plug#end')

require('lualine').get_config()
require('lualine').setup()

