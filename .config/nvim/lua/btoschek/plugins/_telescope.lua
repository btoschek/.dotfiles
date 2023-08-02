local actions = require('telescope.actions')
local config = {
  defaults = {
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    bookmarks = {
      selected_browser = 'firefox',
    },
  },
}

if vim.fn.has('win32') then
  vim.g.sqlite_clib_path = os.getenv('USERPROFILE') .. '/sqlite3/sqlite3.dll'
  config.extensions.bookmarks.url_open_command = 'start firefox'
end

-----------------------------------------------------------------------------
 -- Telescope setup
-----------------------------------------------------------------------------

require('telescope').setup(config)

-----------------------------------------------------------------------------
 -- Extensions
-----------------------------------------------------------------------------

-- Look at your browser bookmarks in NeoVim
require('telescope').load_extension('bookmarks')

-----------------------------------------------------------------------------
 -- Key bindings
-----------------------------------------------------------------------------

vim.keymap.set('n', '<leader>fb',
  '<CMD>Telescope buffers<CR>',
  { desc = 'Manage buffers', noremap = true, silent = true }
)

vim.keymap.set('n', '<Leader>ff',
  '<CMD>Telescope find_files<CR>',
  { desc = 'Find file', noremap = true, silent = true }
)

vim.keymap.set('n', '<Leader>fh',
  '<CMD>Telescope help_tags<CR>',
  { desc = 'Find help tag', noremap = true, silent = true }
)

vim.keymap.set('n', '<Leader>fd',
  function()
    require('telescope.builtin').find_files({
      prompt_title = 'Dotfiles',
      cwd = '~/.config',
    })
  end,
  { desc = 'Browse dotfiles', noremap = true, silent = true }
)
