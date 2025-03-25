require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame = true, -- NOTE: Search for option to display after rust-tools inlay hints
}

-- Patch background highlighting to be the same as the background
vim.cmd [[
  highlight clear SignColumn
  highlight GitGutterAdd guibg=dark
  highlight GitGutterChange guibg=dark
  highlight GitGutterChangeDelete guibg=dark
  highlight GitGutterDelete guibg=dark
]]
