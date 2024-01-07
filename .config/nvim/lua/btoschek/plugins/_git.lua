require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd', text = ' │', numhl = 'GitSignsAddNr', linehl = 'dark' },
    change       = { hl = 'GitSignsChange', text = ' │', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = ' _', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = ' ‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = ' ~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
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

-- Open a toggleterm with lazygit
function Lazygit_toggle()
  local term_command = 'lazygit'

  -- Open dotfiles if not in git directory
  if not require('galaxyline.condition').check_git_workspace() then
    term_command = term_command .. ' --git-dir=' .. vim.env.HOME .. '/.dotfiles/ --work-tree=' .. vim.env.HOME .. '/'
  end

  local terminal = require('toggleterm.terminal').Terminal
  local lazygit  = terminal:new({
    cmd = term_command,
    direction = 'float',
    hidden = true,
  })

  lazygit:toggle()
end

vim.keymap.set('n', '<Leader>gg', Lazygit_toggle, { desc = 'Open lazygit', noremap = true, silent = true })
