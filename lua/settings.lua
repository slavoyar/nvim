HOME = os.getenv("HOME")

vim.g.mapleader = ' '
vim.g.NERDTreeShowHidden = 1


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Backup files
vim.opt.backup = true -- use backup files
vim.opt.writebackup = false
vim.opt.swapfile = false -- do not use swap file
vim.opt.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.opt.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.opt.directory = '/.vim/tmp/swap//'   -- swap files

vim.opt.clipboard = 'unnamedplus'

vim.opt.guifont = "JetBrainsMono Nerd Font:h11"
vim.cmd('colorscheme vscode')

