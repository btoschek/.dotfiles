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

require('which-key').register({
  f = {
    name = 'File',
    b = { '<CMD>Telescope buffers<CR>', 'Manage buffers' },
    d = { '<CMD>Telescope find_files search_dirs={"~/.config"}<CR>', 'Find dotfile' },
    f = { '<CMD>Telescope find_files<CR>', 'Find file' },
    h = { '<CMD>Telescope help_tags<CR>', 'Find help tag' },
  },
}, { prefix = '<Leader>' })
