return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  opts = {

    -- Declare formatters by filetype here, supports chaining them together
    formatters_by_ft = {
      rust = { 'rustfmt' },
    },

    formatters = {
      -- Use Rust 2021 if no Cargo.toml is found
      -- Source: https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md#rustfmt
      rustfmt = { options = { default_edition = "2021", } },
    },

    -- Automatically format on save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
}
