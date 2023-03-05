local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  'jedi_language_server',
  'ansiblels',                       -- Ansible
  'arduino_language_server',         -- Arduino
  'lua_ls',                          -- Lua
  'texlab',                          -- TeX / LaTeX
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

--[[----------------------------------------------------------
                      General LSP Setup
------------------------------------------------------------]]

-- Change diagnostic symbols
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- TODO: What does this do?
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

--[[----------------------------------------------------------
                           Lua Setup
------------------------------------------------------------]]

--[[----------------------------------------------------------
                          Rust Setup
------------------------------------------------------------]]

require('rust-tools').setup {

  -- rust-tools options
  tools = {
    autoSetHints = true,

    inlay_hints = {
      auto = true,
      show_parameter_hints = true,
      parameter_hints_prefix = "ᐊ ",
      other_hints_prefix = "» ",
      max_len_align = false,
    },

    hover_actions = {
      auto_focus = true,
    },
  },

  -- options to send through nvim-lspconfig
  -- overwrites the defaults set by rust-tools
  server = {
    settings = {
      ['rust-analyzer'] = {
        -- enable clippy on save
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
    standalone = false,
    on_attach = function(_, bufnr)
      -- local map = require('utils').keymap_buffer

      --[[
      map('n', '<Leader><Leader>', '<CMD>RustHoverActions<CR>', bufnr)
      map('n', '<Leader>a', '<CMD>RustCodeAction<CR>', bufnr)

      map('n', '<Leader>e', '<CMD>RustExpandMacro<CR>', bufnr)
      map('n', '<Leader>r', '<CMD>RustRunnables<CR>', bufnr)

      map('n', '<Leader>j', '<CMD>RustMoveItemDown<CR>', bufnr)
      map('n', '<Leader>k', '<CMD>RustMoveItemUp<CR>', bufnr)

      map('n', '<Leader>c', '<CMD>RustOpenCargo<CR>', bufnr)
      map('n', '<Leader>p', '<CMD>RustParentModule<CR>', bufnr)
      --]]
    end,
  },
}

-- Autoformat code in .rs files
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('btoschek-writepre', { clear = true }),
  pattern = '*.rs',
  callback = function()
    if vim.lsp.buf.server_ready() then
      vim.lsp.buf.format()
    end
  end
})

require('fidget').setup {
  text = { spinner = 'dots' }
}
