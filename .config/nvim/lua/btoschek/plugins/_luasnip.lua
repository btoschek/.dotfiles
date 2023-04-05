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

-- Stop snippets when leaving insert/substitute mode
-- (Based on: https://github.com/L3MON4D3/LuaSnip/issues/258)
vim.api.nvim_create_autocmd('ModeChanged', {
  group = vim.api.nvim_create_augroup('btoschek-luasnip', { clear = true }),
  callback = function()
    if
      ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})
