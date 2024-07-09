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
}

-----------------------------------------------------------------------------
-- Telescope setup
-----------------------------------------------------------------------------

require('telescope').setup(config)

-----------------------------------------------------------------------------
-- Key bindings
-----------------------------------------------------------------------------

function SearchDotfiles()
  require('telescope.builtin').find_files({
    prompt_title = 'Dotfiles',
    cwd = '~/.config',
  })
end

vim.keymap.set('n', '<Leader>fd',
  function()
    require('telescope.builtin').find_files({
      prompt_title = 'Dotfiles',
      cwd = '~/.config',
    })
  end,
  { desc = 'Browse dotfiles', silent = true }
)
