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
vim.opt.undodir = HOME .. "/.vim/tmp/undo//" -- undo files
vim.opt.backupdir = HOME .. "/.vim/tmp/backup//" -- backups
vim.opt.directory = "/.vim/tmp/swap//" -- swap files

vim.opt.clipboard = "unnamedplus"

vim.opt.guifont = "JetBrainsMono Nerd Font:h11"

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("i", "jk", "<ESC>", {})
vim.wo.number = true

-- Key mappings for debugging (optional)
vim.api.nvim_set_keymap("n", "<F5>", '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", '<cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", '<cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>b",
	'<cmd>lua require("dap").toggle_breakpoint()<CR>',
	{ noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>i", "<cmd>lua vim.diagnostic.open_float()<CR>")
