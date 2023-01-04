-- {{{ LSP Imports
local snip = require('luasnip')

local c   = snip.c
local i   = snip.i
local s   = snip.s
local t   = snip.t

local d   = snip.dynamic_node
local f   = snip.function_node
local sn  = snip.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
-- }}}

return {
  s({ trig = 'snip', name = 'Snippet', dscr = 'Create generic snippet'},
    fmt([===[
      s(info('{}', '{}', '{}'),
        fmt([[
          {}
        ]], {{{}}})),
      ]===], {
      i(1, 'trigger'),
      i(2, 'name'),
      i(3, 'description'),
      i(4),
      i(5)
    })),
}
