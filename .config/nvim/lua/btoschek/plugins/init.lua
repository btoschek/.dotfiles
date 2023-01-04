require('btoschek.plugins._packer')

require('btoschek.plugins._colors')
require('btoschek.plugins._pretty-fold')

require('btoschek.plugins._galaxyline')
require('btoschek.plugins._bufferline')
require('btoschek.plugins._sidebar')

require('btoschek.plugins._todo-comments')
require('btoschek.plugins._nvim-treesitter')

require('btoschek.plugins._mason')
require('btoschek.plugins._lsp')
require('btoschek.plugins._nvim-cmp')
require('btoschek.plugins._luasnip')

require('btoschek.plugins._git')

-- TODO: Move this to actual color settings
vim.cmd [[
  colorscheme tokyonight
  highlight clear SignColumn
]]

vim.cmd [[
  highlight GitGutterAdd guibg=dark
  highlight GitGutterChange guibg=dark
  highlight GitGutterChangeDelete guibg=dark
  highlight GitGutterDelete guibg=dark
]]
