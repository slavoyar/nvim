set number
set relativenumber
set autoindent
set expandtab

" Search settings
set showmatch
set ignorecase
set hlsearch
set incsearch

set noswapfile
set backupdir=~/.cache/vim

set clipboard=unnamedplus
set cc=100

set guifont=JetBrainsMono\ Nerd\ Font\ 11

let mapleader = ' '

call plug#begin("~/.vim/plugged")
 " Plugin Section
 Plug 'Mofiqul/vscode.nvim'
 Plug 'preservim/nerdtree'
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
 Plug 'nvim-lualine/lualine.nvim'
 
 Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme vscode

" NERDTree mapping
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

lua << END
require('lualine').setup()
END
