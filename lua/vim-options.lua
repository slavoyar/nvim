HOME = os.getenv("HOME")

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

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

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

