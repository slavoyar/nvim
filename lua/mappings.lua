function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- NERDTree
vim.cmd('nnoremap <leader>n :NERDTreeFocus<CR>')
vim.cmd('nnoremap <C-n> :NERDTree<CR>')
vim.cmd('nnoremap <C-t> :NERDTreeToggle<CR>')
vim.cmd('nnoremap <C-f> :NERDTreeFind<CR>')

-- window navigation
vim.cmd('nnoremap <C-h> <C-W>h')
vim.cmd('nnoremap <C-l> <C-W>l')
vim.cmd('nnoremap <C-k> <C-W>k')
vim.cmd('nnoremap <C-j> <C-W>j')

-- Insert mode navigation
vim.cmd('inoremap <C-h> <Left>')
vim.cmd('inoremap <C-l> <Right>')
vim.cmd('inoremap <C-k> <Up>')
vim.cmd('inoremap <C-j> <Down>')

-- Move to previous/next
nmap('<A-,>', '<Cmd>BufferPrevious<CR>')
nmap('<A-.>', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
nmap('<A-<>', '<Cmd>BufferMovePrevious<CR>')
nmap('<A->>', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
nmap('<A-1>', '<Cmd>BufferGoto 1<CR>')
nmap('<A-2>', '<Cmd>BufferGoto 2<CR>')
nmap('<A-3>', '<Cmd>BufferGoto 3<CR>')
nmap('<A-4>', '<Cmd>BufferGoto 4<CR>')
nmap('<A-5>', '<Cmd>BufferGoto 5<CR>')
nmap('<A-6>', '<Cmd>BufferGoto 6<CR>')
nmap('<A-7>', '<Cmd>BufferGoto 7<CR>')
nmap('<A-8>', '<Cmd>BufferGoto 8<CR>')
nmap('<A-9>', '<Cmd>BufferGoto 9<CR>')
nmap('<A-0>', '<Cmd>BufferLast<CR>')
-- Pin/unpin buffer
nmap('<A-p>', '<Cmd>BufferPin<CR>')
-- Close buffer
nmap('<A-c>', '<Cmd>BufferClose<CR>')
-- Magic buffer-picking mode
nmap('<C-p>', '<Cmd>BufferPick<CR>')
