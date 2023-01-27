local function map(mode, lhs, rhs, opts)
  local cmd_opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, cmd_opts)
end

-- Map the Leader key
map('n', '<Space>', '<NOP>')
vim.g.mapleader = ' '

-- Center search results
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Split windows faster
map('n', '<Leader>sv', '<CMD>vsplit<CR>')
map('n', '<Leader>sh', '<CMD>split<CR>')

-- Quicker navigation between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Allow gf to open non-existent files
map('n', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Make Y behave like the other capitals
map('n', 'Y', 'y$')

-- Open the current file in the default program
map('n', '<Leader>x', ':!xdg-open %<CR><CR>')
