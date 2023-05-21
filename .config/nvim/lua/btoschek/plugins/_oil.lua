require('oil').setup {
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'n',
  },
  default_file_explorer = true,
  restore_win_options = true,
  skip_confirm_for_simple_edits = false,
  delete_to_trash = false,
  prompt_save_on_select_new_entry = true,
  keymaps = {
    ['g?']    = 'actions.show_help',
    ['<CR>']  = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-']     = 'actions.parent',
    ['_']     = 'actions.open_cwd',
    ['`']     = 'actions.cd',
    ['~']     = 'actions.tcd',
    ['g.']    = 'actions.toggle_hidden',
  },
  use_default_keymaps = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, '.')
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end
  },
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = 'rounded',
    win_options = {
      winblend = 10,
    },
  },
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    win_options = {
      winblend = 0,
    },
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    minimized_border = 'none',
    win_options = {
      winblend = 0,
    },
  },
}

vim.keymap.set('n', '-',
  require('oil').open, {
    desc = 'Open parent directory'
  }
)
