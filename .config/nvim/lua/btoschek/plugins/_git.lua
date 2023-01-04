if _G.plugin_loaded('gitsigns.nvim') then
  require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = ' │', numhl='GitSignsAddNr'   , linehl='dark'},
      change       = {hl = 'GitSignsChange', text = ' │', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = ' _', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = ' ‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = ' ~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    -- WARN: Conflicts with Rust inline hints
    -- current_line_blame = true,
  }

  -- Patch background highlighting to be the same as the background
  vim.cmd [[
    highlight GitGutterAdd guibg=dark
    highlight GitGutterChange guibg=dark
    highlight GitGutterChangeDelete guibg=dark
    highlight GitGutterDelete guibg=dark
  ]]
end
