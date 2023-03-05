require('mason').setup {}

require('mason-lspconfig').setup {
  ensure_installed = {
    'ansiblels',
    'arduino_language_server',
    'ruff_lsp',
    'rust_analyzer',
    'lua_ls',
    'texlab',
  },
}
