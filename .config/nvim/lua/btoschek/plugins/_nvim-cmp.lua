local lsp_icons = {
  Text          = '',
  Method        = '',
  Function      = '',
  Constructor   = '',
  Field         = 'ﴲ',
  Variable      = '',
  Class         = '',
  Interface     = 'ﰮ',
  Module        = '',
  Property      = '',
  Unit          = '',
  Value         = '',
  Enum          = '',
  Keyword       = '',
  Snippet       = '',
  Color         = '',
  File          = '',
  Reference     = '',
  Folder        = '',
  EnumMember    = '',
  Constant      = '',
  Struct        = '',
  Event         = '',
  Operator      = 'ﬦ',
  TypeParameter = '',
}

local lsp_menus = {
  nvim_lsp = 'ﬦ',
  nvim_lua = 'ﬦ',
  luasnip  = '',
  buffer   = '',
  path     = '',
}

-- FROM: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {

  -- Change completion text to use icons
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      item.kind = lsp_icons[item.kind] .. ' ' .. item.kind
      item.menu = lsp_menus[entry.source.name]
      return item
    end
  },

  -- Window outlines
  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Keyboard mappings
  mapping = {
    ['<C-k>']     = cmp.mapping.select_prev_item(),
    ['<C-j>']     = cmp.mapping.select_next_item(),
    ['<C-d>']     = cmp.mapping.scroll_docs(-4),
    ['<C-f>']     = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm { select = true },
    ['<C-e>']     = {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<Tab>']     = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ["<S-Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer',
      option = {
        keyword_pattern = [[\k\+]], -- Modify completion keywords to work with umlauts
      },
    },
    { name = 'calc' },
    { name = 'crates' },
  },
}
