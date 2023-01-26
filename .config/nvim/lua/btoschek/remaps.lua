local default = {
  noremap = true,
  silent = true,
}

local function map(mode, lhs, rhs, opts)
  local opts = opts or default
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Map the Leader key
map('n', '<Space>', '<NOP>')

-- Center search results
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

map('n', '<Leader>vs', '<cmd>vsplit<CR>')
map('n', '<Leader>hs', '<cmd>split<CR>')

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

map('n', 'Y', 'y$')  -- Make Y behave like the other capitals

-- Open the current file in the default program
map('n', '<Leader>x', ':!xdg-open %<CR><CR>')

map('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')
