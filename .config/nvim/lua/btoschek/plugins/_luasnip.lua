local luasnip = require('luasnip')
local types = require('luasnip.util.types')

luasnip.config.setup {
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = { virt_text = {{ '●', 'Number' }} }
    },
    [types.insertNode] = {
      active = { virt_text = {{ '●', 'Constant' }} }
    },
  },
  store_selection_keys = "<Tab>",
  update_events = 'TextChanged,TextChangedI'
}

-- Load snippets from separate directory
require('luasnip.loaders.from_lua').load({
  paths = vim.fn.stdpath('config') .. '/snippets'
})
