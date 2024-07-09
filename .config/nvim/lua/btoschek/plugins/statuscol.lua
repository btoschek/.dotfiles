return {
  'luukvbaal/statuscol.nvim',
  lazy = false,
  config = function()
    local builtin = require('statuscol.builtin')

    require('statuscol').setup({
      segments = {
        {
          sign = { namespace = { "diagnostic" }, wrap = true, auto = true },
          click = 'v:lua.ScSa',
        },
        {
          text = { builtin.lnumfunc, }, -- ' ' },
          click = 'v:lua.ScLa',
        },
        {
          sign = {
            namespace = { "gitsigns" },
            auto = false,
            colwidth = 1,
          },
          click = 'v:lua.ScSa',
        },
        {
          text = { ' ' },
        },
      },
    })
  end,
}
